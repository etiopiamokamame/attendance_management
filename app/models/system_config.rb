# frozen_string_literal: true
class SystemConfig < ApplicationRecord
  validates :base_working_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :base_working_end_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :rest_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :rest_end_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :late_night_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }

  def base_working_start_time
    Time.strptime(base_working_start_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def base_working_start_time_text
    return @base_working_start_time_text unless @base_working_start_time_text.blank?
    base_working_start_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_working_start_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.base_working_start_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.base_working_start_time_hm = nil
  ensure
    @base_working_start_time_text = value
  end

  def base_working_end_time
    Time.strptime(base_working_end_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def base_working_end_time_text
    return @base_working_end_time_text unless @base_working_end_time_text.blank?
    base_working_end_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_working_end_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.base_working_end_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.base_working_end_time_hm = nil
  ensure
    @base_working_end_time_text = value
  end

  def rest_start_time
    Time.strptime(rest_start_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def rest_start_time_text
    return @rest_start_time_text unless @rest_start_time_text.blank?
    rest_start_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def rest_start_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.rest_start_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.rest_start_time_hm = nil
  ensure
    @rest_start_time_text = value
  end

  def rest_end_time
    Time.strptime(rest_end_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def rest_end_time_text
    return @rest_end_time_text unless @rest_end_time_text.blank?
    rest_end_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def rest_end_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.rest_end_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.rest_end_time_hm = nil
  ensure
    @rest_end_time_text = value
  end

  def late_night_time
    Time.strptime(late_night_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def late_night_time_text
    return @late_night_time_text unless @late_night_time_text.blank?
    late_night_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def late_night_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.late_night_time_hm = time.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.late_night_time_hm = nil
  ensure
    @late_night_time_text = value
  end

  def weeks
    return [] if holiday_weeks.blank?
    holiday_weeks.split(",").map(&:to_i)
  end

  def weeks=(value)
    self.holiday_weeks = value.select(&:present?).join(",")
  end
end
