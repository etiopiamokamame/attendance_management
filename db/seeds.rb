# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(admin: "1", number: "00000") do |u|
  u.name             = "管理者"
  u.affiliation_name = "管理職"
  u.password         = "admin"
  u.password_confirm = u.password
end

User.find_or_create_by(admin: "0", number: "99999") do |u|
  u.name             = "一般利用者"
  u.affiliation_name = "一般職"
  u.password         = "user"
  u.password_confirm = u.password
end

SystemConfig.find_or_create_by(id: 1) do |s|
  s.base_working_start_time       = "09:00"
  s.base_working_end_time         = "18:00"
  s.rest_start_time               = "12:00"
  s.rest_end_time                 = "13:00"
  s.base_overtime_rest_start_time = "18:00"
  s.base_overtime_rest_end_time   = "18:30"
  s.late_night_time               = "22:00"
  s.time_off_hours_prospect       = 30.0
end

Reason.find_or_create_by(id: 1) do |r|
  r.content = "月例会議(19:00～21:00)"
end

LeaveType.find_or_create_by(id: 1) do |l|
  l.content = "年休"
end
