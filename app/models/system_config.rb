class SystemConfig < ActiveRecord::Base
  validates :base_working_start_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :base_working_end_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :rest_start_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :rest_end_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :base_overtime_rest_start_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :base_overtime_rest_end_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :late_night_time_duration,
    presence: true,
    format: { with: %r{[0-9|-]{2}:[0-9]{2}}, allow_blank: true }
  validates :time_off_hours_prospect,
    presence:     true,
    numericality: { greater_than_or_equal_to: 0, allow_blank: true }


  def base_working_start_time_duration
    return nil if self.base_working_start_time.blank?
    Time.strptime(self.base_working_start_time, "%H:%M")
  end

  def base_working_start_time_duration=(value)
    self.base_working_start_time = value
  end

  def base_working_end_time_duration
    return nil if self.base_working_end_time.blank?
    Time.strptime(self.base_working_end_time, "%H:%M")
  end

  def base_working_end_time_duration=(value)
    self.base_working_end_time = value
  end

  def rest_start_time_duration
    return nil if self.rest_start_time.blank?
    Time.strptime(self.rest_start_time, "%H:%M")
  end

  def rest_start_time_duration=(value)
    self.rest_start_time = value
  end

  def rest_end_time_duration
    return nil if self.rest_end_time.blank?
    Time.strptime(self.rest_end_time, "%H:%M")
  end

  def rest_end_time_duration=(value)
    self.rest_end_time = value
  end

  def base_overtime_rest_start_time_duration
    return nil if self.base_overtime_rest_start_time.blank?
    Time.strptime(self.base_overtime_rest_start_time, "%H:%M")
  end

  def base_overtime_rest_start_time_duration=(value)
    self.base_overtime_rest_start_time = value
  end

  def base_overtime_rest_end_time_duration
    return nil if self.base_overtime_rest_end_time.blank?
    Time.strptime(self.base_overtime_rest_end_time, "%H:%M")
  end

  def base_overtime_rest_end_time_duration=(value)
    self.base_overtime_rest_end_time = value
  end

  def late_night_time_duration
    return nil if self.late_night_time.blank?
    Time.strptime(self.late_night_time, "%H:%M")
  end

  def late_night_time_duration=(value)
    self.late_night_time = value
  end
end
