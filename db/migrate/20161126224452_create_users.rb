class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string  :admin,                     null: false, limit: 1, default: 0
      t.string  :name
      t.string  :affiliation_name
      t.string  :number
      t.string  :password
      t.integer :last_year_paid_holiday
      t.integer :current_year_paid_holiday
      t.integer :remaining_transfer_holiday
      t.integer :lock_version,              null: false, default: 0
      t.string  :deleted,                   null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
