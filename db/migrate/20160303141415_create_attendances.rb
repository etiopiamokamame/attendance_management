class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user,         null: false
      t.integer    :year
      t.integer    :month
      t.string     :site_start_time
      t.string     :site_end_time
      t.string     :details
      t.integer    :lock_version, null: false, default: 0
      t.boolean    :deleted,      null: false, default: false

      t.timestamps null: false
    end
  end
end
