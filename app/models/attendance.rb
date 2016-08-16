class Attendance < ApplicationRecord
  belongs_to :user

  def date
    return nil if year.blank? || month.blank?
    Date.new(year, month)
  end

  def date_str
    return nil if year.blank? || month.blank?
    "%04d年%02d月" % [year, month]
  end

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

  def display_rest_start_time
    return self.rest_start_time unless self.rest_start_time.blank?
    SystemConfig.first.rest_start_time
  end

  def display_rest_start_time=(value)
    self.rest_start_time = value
  end

  def display_rest_end_time
    return self.rest_end_time unless self.rest_end_time.blank?
    SystemConfig.first.rest_end_time
  end

  def display_rest_end_time=(value)
    self.rest_end_time = value
  end

  def display_details
    if details.blank?
      now_month  = Date.new(self.year, self.month)
      start_day  = now_month.beginning_of_month
      end_day    = now_month.end_of_month
      holi_weeks = SystemConfig.first.weeks
      holis      = Holiday.availability.pluck(:year, :month, :day).map { |h| "%04d%02d%02d" % h }
      (start_day..end_day).map do |date|
        holi_flag              = holis.include?("%04d%02d%02d" % [date.year, date.month, date.day])
        options                = {}
        options[:week]         = date.wday
        options[:holiday_flag] = (holi_weeks.include?(date.wday) || holi_flag) ? "1" : "0"
        AttendanceDetail.new(date.day, options)
      end
    else
      YAML.load(details).map do |detail|
        options = detail.dup
        AttendanceDetail.new(options.delete(:day), options)
      end
    end
  end

  def display_details=(values)
    objs = values.map do |day, options|
      AttendanceDetail.new(day, options).attributes
    end
    self.details = YAML.dump objs
  end

  def entries_month
    return if date.blank?
    date.to_era(self.class.human_attribute_name(:attendance_year_format))
  end

  def entries_era_year
    return if date.blank?
    date.to_era(self.class.human_attribute_name(:attendance_era_year))
  end

  def entries_abbr_era_year
    return if date.blank?
    date.to_era(self.class.human_attribute_name(:attendance_abbr_era_year))
  end
end
