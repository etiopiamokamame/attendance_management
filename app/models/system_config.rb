# frozen_string_literal: true
class SystemConfig < ApplicationRecord
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

  def time_off_hours_prospect_text
    time = Time.strptime(time_off_hours_prospect, I18n.t(:default_time_format, separate: nil))
    time.strftime(I18n.t(:default_time_format, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def base_working_start_time_text=(value)
    binding.pry
    # self.base_working_start_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.base_working_start_time = nil
  end

  def base_working_end_time_text=(value)
    binding.pry
    # self.base_working_end_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.base_working_end_time = nil
  end

  def rest_start_time_text=(value)
    binding.pry
    # self.rest_start_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.rest_start_time = nil
  end

  def rest_end_time_text=(value)
    binding.pry
    # self.rest_end_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.rest_end_time = nil
  end

  def base_overtime_rest_start_time_text=(value)
    binding.pry
    # self.base_overtime_rest_start_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.base_overtime_rest_start_time = nil
  end

  def base_overtime_rest_end_time_text=(value)
    binding.pry
    # self.base_overtime_rest_end_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.base_overtime_rest_end_time = nil
  end

  def late_night_time_text=(value)
    binding.pry
    # self.late_night_time = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.late_night_time = nil
  end

  def time_off_hours_prospect_text=(value)
    binding.pry
    # self.time_off_hours_prospect = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.time_off_hours_prospect = nil
  end

  def weeks
    return [] if holiday_weeks.blank?
    holiday_weeks.split(",").map(&:to_i)
  end

  def weeks=(value)
    self.holiday_weeks = value.select(&:present?).join(",")
  end
end
