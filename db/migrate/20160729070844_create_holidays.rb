class CreateHolidays < ActiveRecord::Migration[5.0]
  def change
    create_table :holidays do |t|
      t.integer :year,         null: false
      t.integer :month,        null: false
      t.integer :day,          null: false
      t.string  :name,         null: false
      t.integer :lock_version, null: false, default: 0
      t.string  :deleted,      null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
