class CreateWorkingReports < ActiveRecord::Migration
  def change
    create_table :working_reports do |t|
      t.references :user,           null: false
      t.integer    :fiscal_year
      t.integer    :month
      t.string     :working_time
      t.string     :off_hours_time
      t.string     :late_night_time
      t.string     :shortfall_time
      t.integer    :lock_version,   null: false, default: 0
      t.boolean    :deleted,        null: false, default: false

      t.timestamps null: false
    end
  end
end
