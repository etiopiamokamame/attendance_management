class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_configs do |t|
      t.string  :company_name
      t.string  :base_working_start_time
      t.string  :base_working_end_time
      t.string  :rest_start_time
      t.string  :rest_end_time
      t.boolean :enable_base_overtime_rest_time, null: false, default: true
      t.string  :base_overtime_rest_start_time
      t.string  :base_overtime_rest_end_time
      t.string  :late_night_time
      t.float   :time_off_hours_prospect
      t.integer :lock_version, null: false, default: 0
      t.boolean :deleted,      null: false, default: false

      t.timestamps null: false
    end
  end
end
