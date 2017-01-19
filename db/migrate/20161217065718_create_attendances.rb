class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :user,               null: false
      t.string     :date_ym,            null: false, limit: 6
      t.string     :site_start_time_hm, null: false, limit: 4
      t.string     :site_end_time_hm,   null: false, limit: 4
      t.string     :rest_start_time_hm, null: false, limit: 4
      t.string     :rest_end_time_hm,   null: false, limit: 4
      t.text       :details
      t.integer    :lock_version,       null: false, default: 0
      t.string     :deleted,            null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
