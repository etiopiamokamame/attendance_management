# frozen_string_literal: true
class SystemConfig < ApplicationRecord
  validates :base_working_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :base_working_end_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :rest_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :rest_end_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :base_overtime_rest_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :base_overtime_rest_end_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :late_night_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }

  def base_working_start_time_text
    time = Time.strptime(base_working_start_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_working_end_time_text
    time = Time.strptime(base_working_end_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def rest_start_time_text
    time = Time.strptime(rest_start_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def rest_end_time_text
    time = Time.strptime(rest_end_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_overtime_rest_start_time_text
    time = Time.strptime(base_overtime_rest_start_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_overtime_rest_end_time_text
    time = Time.strptime(base_overtime_rest_end_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def late_night_time_text
    time = Time.strptime(late_night_time, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_working_start_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.base_working_start_time = time.strftime(I18n.t(:default_time_format, separate: nil))
  rescue
    self.base_working_start_time = nil
  end

  def base_working_end_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.base_working_end_time = time.strftime(I18n.t(:default_time_format, separate: nil))
  rescue
    self.base_working_end_time = nil
  end

  def rest_start_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.rest_start_time = time.strftime(I18n.t(:default_time_format, separate: nil))
  rescue
    self.rest_start_time = nil
  end

  def rest_end_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.rest_end_time = time.strftime(I18n.t(:default_time_format, separate: nil))
  rescue
    self.rest_end_time = nil
  end

  def late_night_time_text=(value)
    time = Time.strptime(value, I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.late_night_time = time.strftime(I18n.t(:default_time_format, separate: nil))
  rescue
    self.late_night_time = nil
  end

  def weeks
    return [] if holiday_weeks.blank?
    holiday_weeks.split(",").map(&:to_i)
  end

  def weeks=(value)
    self.holiday_weeks = value.select(&:present?).join(",")
  end
end
