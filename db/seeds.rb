User.create do |u|
  u.admin            = true
  u.name             = "管理者"
  u.affiliation_name = "管理職"
  u.number           = "00000"
  u.password         = "admin"
  u.password_confirm = u.password
end

User.create do |u|
  u.admin            = false
  u.name             = "一般利用者"
  u.affiliation_name = "一般職"
  u.number           = "99999"
  u.password         = "user"
  u.password_confirm = u.password
end

SystemConfig.create do |s|
  s.base_working_start_time       = "09:00"
  s.base_working_end_time         = "18:00"
  s.rest_start_time               = "12:00"
  s.rest_end_time                 = "13:00"
  s.base_overtime_rest_start_time = "18:00"
  s.base_overtime_rest_end_time   = "18:30"
  s.late_night_time               = "22:00"
  s.time_off_hours_prospect       = 30.0
end

Reason.create do |r|
  r.content = "月例会議(19:00～21:00)"
end

LeaveType.create do |l|
  l.content = "年休"
end
