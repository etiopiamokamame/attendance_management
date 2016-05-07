class Attendance < ActiveRecord::Base
  belongs_to :user

  serialize :details, SerializeAttendanceDetail.new

  def display_site_start_time
    return self.site_start_time_duration unless self.site_start_time.blank?
    SystemConfig.first.base_working_start_time_duration
  end

  def site_start_time_duration
    return nil if self.site_start_time.blank?
    Time.strptime(self.site_start_time, "%H:%M")
  end
  def display_site_start_time=(value)
    self.site_start_time = value
  end

  def display_site_end_time
    return self.site_end_time_duration unless self.site_end_time.blank?
    SystemConfig.first.base_working_end_time_duration
  end

  def site_end_time_duration
    return nil if self.site_end_time.blank?
    Time.strptime(self.site_end_time, "%H:%M")
  end

  def display_site_end_time=(value)
    self.site_end_time = value
  end

  def display_details
    return self.details unless self.details.blank?
    now_month = Date.new(self.year, self.month)
    start_day = now_month.beginning_of_month
    end_day   = now_month.end_of_month
    (start_day..end_day).map do |date|
      AttendanceDetail.new(date.day, {week: date.wday})
    end
  end
end
