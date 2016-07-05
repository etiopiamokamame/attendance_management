class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :year,         null: false
      t.integer :month,        null: false
      t.integer :day,          null: false
      t.string  :name,         null: false
      t.integer :lock_version, null: false, default: 0
      t.boolean :deleted,      null: false, default: false

      t.timestamps null: false
    end
  end
end
