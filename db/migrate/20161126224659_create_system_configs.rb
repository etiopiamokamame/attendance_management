class CreateSystemConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :system_configs do |t|
      t.string  :company_name
      t.string  :base_working_start_time_hm,       limit: 4
      t.string  :base_working_end_time_hm,         limit: 4
      t.string  :rest_start_time_hm,               limit: 4
      t.string  :rest_end_time_hm,                 limit: 4
      t.string  :enable_base_overtime_rest_time,   limit: 1, default: 1
      t.string  :base_overtime_rest_start_time_hm, limit: 4
      t.string  :base_overtime_rest_end_time_hm,   limit: 4
      t.string  :late_night_time_hm,               limit: 4
      t.float   :time_off_hours_prospect
      t.string  :holiday_weeks
      t.integer :lock_version,                     null: false, default: 0
      t.string  :deleted,                          null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
