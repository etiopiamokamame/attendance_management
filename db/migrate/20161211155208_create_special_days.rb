class CreateSpecialDays < ActiveRecord::Migration[5.0]
  def change
    create_table :special_days do |t|
      t.string  :date,         null: false, limit: 8
      t.string  :name,         null: false
      t.string  :day_type,     null: false, limit: 3
      t.integer :lock_version, null: false, default: 0
      t.string  :deleted,      null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
