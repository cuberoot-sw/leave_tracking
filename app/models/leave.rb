class Leave < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :start_date, :end_date, :reason

  validate :validate_dates

  before_save :calculate_leaves

  self.per_page = 10

  def validate_dates
    if (start_date.present? && end_date.present? && (start_date > end_date))
      errors.add(:start_date, "must be earlier than end date")
    end
  end


  # state_machine
  state_machine :status, :initial => :pending do
    event :approve do
      transition [:pending] => :approved
    end

    event :reject do
      transition [:pending] => :rejected
    end

    event :cancel do
      transition [:pending, :approved, :rejected] => :cancelled
    end

    state :approved, :pending, :rejected, :cancelled
  end

  def notify_email(curr_user=false)
    LeaveMailer.send("notify_#{self.status}_leave", self, curr_user).deliver
  end

  def notify_updated_email(curr_user=false)
    LeaveMailer.notify_updated_leave(self, curr_user).deliver
  end

  def add_reason(reason)
    self.rejection_reason = reason
  end

  def update_leave(user)
    self.approved_by = user.id
    self.approved_on = Time.now
    self.save
  end

  def calculate_leaves
    self.no_of_days = calculate_applied_leaves
  end

  ## if use is newly joined then total_leaves = months_in_year from joining * leave_rate_per_month
  ## else 12 * leave_rate_per_month
  def self.calculate_total_leaves(curr_user)
    user = curr_user || self.user
    curr_year = Time.now.year
    if curr_year == (user.date_of_joining).year
      diff = ("#{curr_year}/12/31".to_date) - (user.date_of_joining.to_date)
      total_months = (diff/30).round
      total_leaves = total_months * Yetting.leave_rate_per_month
    else
      total_leaves = 12 * Yetting.leave_rate_per_month
    end
  end


  # no of days for leave automatically calculated, excluding weekends
  # and holidays
  def calculate_applied_leaves
    @govt_holiday = Holiday.where(["date between ? and ? ",
                                   start_date, end_date]).count

    business_days = ActiveRecord::Base.connection.select_all("select uGetBussinessDays('#{start_date}', '#{end_date}') as b_days").first
    no_of_days = business_days['b_days'].to_i - @govt_holiday
    no_of_days
  end

  # calculate balance leaves
  def self.balance_leaves(user)
    ## Total number of leaves in year = total_leaves
    ## Total number of applied leaves = applied_leaves
    ## Remaining number of leaves = remaining_leaves
    total_leaves = calculate_total_leaves(user)
    applied_leaves = total_applied_leaves(user)
    remaining_leaves = total_leaves.to_f - applied_leaves.to_f
    return remaining_leaves
  end

  def self.total_applied_leaves(user, year=false)
    year = year || Time.now.year
    no_of_days = Leave.where('extract(year from start_date) = ? AND
                 user_id = ? AND (status = ? OR status = ?)', year,
                 user.id, 'pending', 'approved').sum(:no_of_days)
    return no_of_days
  end

  ## to get resources leaves
  def self.resources_leaves(user, status)
    Leave.joins(:user).where('users.manager_id = ?
                              AND leaves.status = ?',
                              user.id, status)
  end

  ## get all_leaves with manager to employee level
  def self.all_leaves(user, status)
    @leaves = Leave.resources_leaves(user, status)
    @managers = User.where(manager_id: user.id)
    @managers.each do |manager|
      @leaves += Leave.resources_leaves(manager, status)
    end
    return @leaves
  end

end
