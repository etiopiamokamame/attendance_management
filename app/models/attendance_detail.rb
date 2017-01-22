# frozen_string_literal: true
class AttendanceDetail
  include ActiveModel::Model

  attr_accessor :day,                     # 日
                :week,                    # 曜日
                :work_start_time_hm,      # 就業始業時間
                :work_end_time_hm,        # 就業終業時間
                :working_time_hm,         # 労働時間
                :off_hours_time_hm,       # 時間外時間
                :late_night_time_hm,      # 深夜時間
                :time_holiday_hm,         # 時年時間
                :shortfall_time_hm,       # 不足時間
                :reason,                  # 事由
                :leave_type_id,           # 休暇種別
                :rest_out_of_standard_hm, # 基準外休憩
                :holiday_flag             # 休日フラグ

  validates :work_start_time_text,
            presence: { unless: :holiday? },
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }
  validates :work_end_time_text,
            presence: { unless: :holiday? },
            time: { format: I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG),
                    allow_blank: true }

  delegate :content,
           to:        :leave_type,
           prefix:    true,
           allow_nil: true

  def initialize(day, h = {})
    opt                            = h.symbolize_keys
    self.day                       = day
    self.week                      = opt[:week]
    self.work_start_time_text      = opt[:work_start_time_text]
    self.work_end_time_text        = opt[:work_end_time_text]
    self.working_time_text         = opt[:working_time_text]
    self.off_hours_time_text       = opt[:off_hours_time_text]
    self.late_night_time_text      = opt[:late_night_time_text]
    self.time_holiday_text         = opt[:time_holiday_text]
    self.shortfall_time_text       = opt[:shortfall_time_text]
    self.reason                    = opt[:reason]
    self.leave_type_id             = opt[:leave_type_id]
    self.rest_out_of_standard_text = opt[:rest_out_of_standard_text]
    self.holiday_flag              = opt[:holiday_flag]
  end

  def week_name
    CONSTANTS::WEEKS[week.to_i]
  end

  def work_start_time
    Time.strptime(work_start_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def work_start_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @work_start_time_text unless @work_start_time_text.blank?
    work_start_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def work_start_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.work_start_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.work_start_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @work_start_time_text = value
  end

  def work_end_time_time
    Time.strptime(work_end_time_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def work_end_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @work_end_time_text unless @work_end_time_text.blank?
    work_end_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def work_end_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.work_end_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.work_end_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @work_end_time_text = value
  end

  def working_time
    Time.strptime(working_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def working_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @working_time_text unless @working_time_text.blank?
    working_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def working_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.working_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.working_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @working_time_text = value
  end

  def off_hours_time
    Time.strptime(off_hours_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def off_hours_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @off_hours_time_text unless @off_hours_time_text.blank?
    off_hours_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def off_hours_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.off_hours_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.off_hours_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @off_hours_time_text = value
  end

  def late_night_time
    Time.strptime(late_night_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def late_night_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @late_night_time_text unless @late_night_time_text.blank?
    late_night_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def late_night_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.late_night_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.late_night_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @late_night_time_text = value
  end

  def time_holiday
    Time.strptime(time_holiday_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def time_holiday_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @time_holiday_text unless @time_holiday_text.blank?
    time_holiday.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def time_holiday_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.time_holiday_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.time_holiday_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @time_holiday_text = value
  end

  def shortfall_time
    Time.strptime(shortfall_time_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def shortfall_time_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @shortfall_time_text unless @shortfall_time_text.blank?
    shortfall_time.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def shortfall_time_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.shortfall_time_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.shortfall_time_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @shortfall_time_text = value
  end

  def leave_type
    LeaveType.find_by(id: leave_type_id)
  end

  def rest_out_of_standard
    Time.strptime(rest_out_of_standard_hm, I18n.t(:default_time_format_hm, separate: nil))
  rescue
    nil
  end

  def rest_out_of_standard_text(separate = CONSTANTS::TIME_SEPARATE_TAG)
    return @rest_out_of_standard_text unless @rest_out_of_standard_text.blank?
    rest_out_of_standard.strftime(I18n.t(:default_time_format_hm, separate: separate))
  rescue
    nil
  end

  def rest_out_of_standard_text=(value)
    time_value = Time.strptime(value, I18n.t(:default_time_format_hm, separate: CONSTANTS::TIME_SEPARATE_TAG))
    self.rest_out_of_standard_hm = time_value.strftime(I18n.t(:default_time_format_hm, separate: nil))
  rescue
    self.rest_out_of_standard_hm = CONSTANTS::TIME_SEPARATE_TAG
  ensure
    @rest_out_of_standard_text = value
  end

  def holiday?
    holiday_flag == "1"
  end
end
