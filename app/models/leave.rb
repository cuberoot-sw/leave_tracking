class Leave < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :start_date, :end_date, :reason

  validate :validate_dates

  # after_save :notify_email

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

  def notify_email
    if pending?
      LeaveMailer.notify_pending_leave(self).deliver
    elsif approved?
      LeaveMailer.notify_approved_leave(self).deliver
    elsif rejected?
      LeaveMailer.notify_rejected_leave(self).deliver
    end
  end

  def add_reason(reason)
    self.rejection_reason = reason
  end
end
