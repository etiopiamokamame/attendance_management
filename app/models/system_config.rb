class SystemConfig < ActiveRecord::Base

  before_validation :delete_base_overtime_rest_time,
    unless: :enable_base_overtime_rest_time?

  validates :base_working_start_time,
    presence: true,
    time:     { allow_blank: true }
  validates :base_working_end_time,
    presence: true,
    time:     { allow_blank: true }
  validates :rest_start_time,
    presence: true,
    time:     { allow_blank: true }
  validates :rest_end_time,
    presence: true,
    time:     { allow_blank: true }
  validates :base_overtime_rest_start_time,
    presence: true,
    time:     { allow_blank: true },
    if: :enable_base_overtime_rest_time?
  validates :base_overtime_rest_end_time,
    presence: true,
    time:     { allow_blank: true },
    if: :enable_base_overtime_rest_time?
  validates :late_night_time,
    presence: true,
    time:     { allow_blank: true }
  validates :time_off_hours_prospect,
    presence:     true,
    numericality: { greater_than_or_equal_to: 0, allow_blank: true }

  private

  def enable_base_overtime_rest_time?
    self.enable_base_overtime_rest_time
  end

  def delete_base_overtime_rest_time
    self.base_overtime_rest_start_time = nil
    self.base_overtime_rest_end_time   = nil
  end
end
