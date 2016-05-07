class AttendanceDetail
  # 日  初期値有り  入力なし
  attr_accessor :day
  # 曜日  初期値有り  入力なし
  attr_accessor :week
  # 就業始業時間  初期値なし  入力アリ  条件付き必須事項
  attr_accessor :work_start_time
  # 就業就業時間  初期値なし  入力アリ  条件付き必須事項
  attr_accessor :work_end_time
  # 労働時間  初期値なし  入力なし  保存後計算
  attr_accessor :working_time
  # 時間外時間  初期値なし  入力なし  保存後計算
  attr_accessor :off_hours_time
  # 深夜時間  初期値なし  入力なし  保存後計算
  attr_accessor :late_night_time
  # 時年時間  初期値なし  入力可  条件付き必須事項
  attr_accessor :time_holiday
  # 不足時間  初期値0  保存後計算
  attr_accessor :shortfall_time
  # 事由  初期値なし  選択または入力
  attr_accessor :reason
  # 休暇種別  初期値なし  条件付き選択必須
  attr_accessor :leave_type_id
  # 基準外休憩  初期値なし  条件付き入力必須
  attr_accessor :rest_out_of_standard

  def initialize(day, h)
    h                         = h.symbolize_keys
    @day                      = day
    @week                     = h[:week]
    self.work_start_time      = h[:work_start_time_duration]
    self.work_end_time        = h[:work_end_time_duration]
    self.working_time         = h[:working_time_duration]
    self.off_hours_time       = h[:off_hours_time_duration]
    self.late_night_time      = h[:late_night_time_duration]
    self.time_holiday         = h[:time_holiday_duration]
    self.shortfall_time       = h[:shortfall_time_duration]
    self.reason               = h[:reason]
    self.leave_type_id        = h[:leave_type_id]
    self.rest_out_of_standard = h[:rest_out_of_standard_duration]
  end

  def work_start_time_duration
    return nil if self.work_start_time.blank?
    Time.strptime(self.work_start_time, "%H:%M")
  end

  def work_end_time_duration
    return nil if self.work_end_time.blank?
    Time.strptime(self.work_end_time, "%H:%M")
  end

  def working_time_duration
    return nil if self.working_time.blank?
    Time.strptime(self.working_time, "%H:%M")
  end

  def off_hours_time_duration
    return nil if self.off_hours_time.blank?
    Time.strptime(self.off_hours_time, "%H:%M")
  end

  def late_night_time_duration
    return nil if self.late_night_time.blank?
    Time.strptime(self.late_night_time, "%H:%M")
  end

  def time_holiday_duration
    return nil if self.time_holiday.blank?
    Time.strptime(self.time_holiday, "%H:%M")
  end

  def shortfall_time_duration
    return nil if self.shortfall_time.blank?
    Time.strptime(self.shortfall_time, "%H:%M")
  end

  def rest_out_of_standard_duration
    return nil if self.rest_out_of_standard.blank?
    Time.strptime(self.rest_out_of_standard, "%H:%M")
  end
end
