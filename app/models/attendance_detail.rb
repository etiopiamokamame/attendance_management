class AttendanceDetail
  include ActiveModel::Model

  # 日
  attr_accessor :day
  # 曜日
  attr_accessor :week
  # 就業始業時間
  attr_accessor :work_start_time
  # 就業就業時間
  attr_accessor :work_end_time
  # 労働時間
  attr_accessor :working_time
  # 時間外時間
  attr_accessor :off_hours_time
  # 深夜時間
  attr_accessor :late_night_time
  # 時年時間
  attr_accessor :time_holiday
  # 不足時間
  attr_accessor :shortfall_time
  # 事由
  attr_accessor :reason
  # 休暇種別
  attr_accessor :leave_type_id
  # 基準外休憩
  attr_accessor :rest_out_of_standard
  # 休日フラグ
  attr_accessor :holiday_flag

  def initialize(day, h)
    h                         = h.symbolize_keys
    @day                      = day
    @week                     = h[:week]
    self.work_start_time      = h[:work_start_time]
    self.work_end_time        = h[:work_end_time]
    self.working_time         = h[:working_time]
    self.off_hours_time       = h[:off_hours_time]
    self.late_night_time      = h[:late_night_time]
    self.time_holiday         = h[:time_holiday]
    self.shortfall_time       = h[:shortfall_time]
    self.reason               = h[:reason]
    self.leave_type_id        = h[:leave_type_id]
    self.rest_out_of_standard = h[:rest_out_of_standard]
    self.holiday_flag         = h[:holiday_flag]
  end

  def holiday?
    holiday_flag == "1"
  end

  def attributes
    instance_variable_names.each_with_object({}) do |name, hash|
      method_name = name[1..-1]
      hash[method_name.to_sym] = __send__(method_name)
    end
  end
end
