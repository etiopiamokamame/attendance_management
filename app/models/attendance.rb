# frozen_string_literal: true
class Attendance < ApplicationRecord
  belongs_to :user

  scope :availability, -> {
    where(deleted: "0")
  }

  scope :fiscal_year, -> {
    today     = Date.today
    table     = arel_table
    from, to  = if CONSTANTS::START_FISCAL_YEAR <= today.month
                  [
                    Date.new(today.year, CONSTANTS::START_FISCAL_YEAR, 1),
                    Date.new(today.next_year.year, CONSTANTS::END_FISCAL_YEAR, 1)
                  ]
                else
                  [
                    Date.new(today.prev_year.year, CONSTANTS::START_FISCAL_YEAR, 1),
                    Date.new(today.year, CONSTANTS::END_FISCAL_YEAR, 1)
                  ]
                end

    query = table[:date_ym].gteq(from.strftime(I18n.t(:default_date_format_ym, separate: nil)))
    query = query.and(table[:date_ym].lteq(to.strftime(I18n.t(:default_date_format_ym, separate: nil))))

    where(query).availability.order_months
  }

  scope :order_months, -> {
    order(date_ym: :asc)
  }

  validates :site_start_time_text,
            presence: true,
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :site_end_time_text,
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
  validate :validate_details

  def entries_month
    return if date.blank?
    date.to_era(I18n.t(:era_date_format_ym))
  end

  def date
    Date.strptime(date_ym, I18n.t(:default_date_format_ym, separate: nil))
  rescue
    nil
  end

  def date_text
    return @date_text unless @date_text.blank?
    date.strftime(I18n.t(:date_format_ym))
  rescue
    nil
  end

  def site_start_time
    Time.strptime(site_start_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def site_start_time_text
    return @site_start_time_text unless @site_start_time_text.blank?
    site_start_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def site_start_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.site_start_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.site_start_time_hm = nil
  ensure
    @site_start_time_text = value
  end

  def site_end_time
    Time.strptime(site_end_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def site_end_time_text
    return @site_end_time_text unless @site_end_time_text.blank?
    site_end_time.strftime(I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
  rescue
    nil
  end

  def site_end_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.site_end_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.site_end_time_hm = nil
  ensure
    @site_end_time_text = value
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

  def period
    return [] if date.blank?
    date.beginning_of_month..date.end_of_month
  end

  def date_month_text
    date.strftime(I18n.t(:date_format_m))
  rescue
    nil
  end

  def date_text=(value)
    date_value = Date.strptime(value, I18n.t(:date_format_ym))
    self.date_ym = date_value.strftime(I18n.t(:default_date_format_ym, separate: nil))
  rescue
    self.date_ym = nil
    @date_text = value
  end

  def active_month?
    date == Date.today.beginning_of_month
  end

  def attendance_details
    if details.blank?
      holi_weeks = SystemConfig.first.weeks
      holis      = SpecialDay.holodays.map(&:date)
      busis      = SpecialDay.business_days.map(&:date)

      period.map do |day|
        options                = {}
        options[:week]         = day.wday
        holiday_flag           = busis.exclude?(day) && (holi_weeks.include?(day.wday) || holis.include?(day))
        options[:holiday_flag] = holiday_flag ? "1" : "0"
        AttendanceDetail.new(day.day, options)
      end
    else
      return @attendance_details unless @attendance_details.blank?

      YAML.safe_load(details).map do |day, detail|
        AttendanceDetail.new(day, detail)
      end
    end
  end

  def attendance_details=(value)
    self.details = if value.blank?
                     nil
                   else
                     YAML.dump value
                   end

    @attendance_details = if value.blank?
                            nil
                          else
                            value.map do |day, detail|
                              AttendanceDetail.new(day, detail)
                            end
                          end
  end

  def total_work_time
    0
  end

  def total_deemed_overtime
    0
  end

  def total_overtime
    0
  end

  def late_night_time
    0
  end

  def time_holiday
    0
  end

  def shortfall_time
    0
  end

  private

  def validate_details
    return if @attendance_details.map(&:valid?).all?
    errors.add(:details, :invalid)
  end
end
