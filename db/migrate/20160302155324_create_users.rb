class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin,                     null: false, default: false
      t.string  :name
      t.string  :affiliation_name
      t.string  :number
      t.string  :password
      t.integer :last_year_paid_holiday
      t.integer :current_year_paid_holiday
      t.integer :remaining_transfer_holiday
      t.integer :lock_version,              null: false, default: 0
      t.boolean :deleted,                   null: false, default: false

      t.timestamps null: false
    end
  end
end
