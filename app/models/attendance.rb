class Attendance < ActiveRecord::Base
  belongs_to :user

  serialize :details, SerializeAttendanceDetail.new

  def display_site_start_time
    return self.site_start_time unless self.site_start_time.blank?
    SystemConfig.first.base_working_start_time
  end

  def display_site_start_time=(value)
    self.site_start_time = value
  end

  def display_site_end_time
    return self.site_end_time unless self.site_end_time.blank?
    SystemConfig.first.base_working_end_time
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

  def entries_month
    date_format = I18n.t("attendances.index.attendance_year_format")
    Date.new(self.year, self.month).to_era(date_format)
  end
end
