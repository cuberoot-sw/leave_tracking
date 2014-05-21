class Leave < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :start_date, :end_date, :reason

  validate :validate_dates

  def validate_dates
    if (start_date.present? && end_date.present? && (start_date > end_date))
      errors.add(:start_date, "must be earlier than end date")
    end
  end
end
