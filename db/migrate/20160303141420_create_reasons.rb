class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string  :content
      t.integer :lock_version, null: false, default: 0
      t.boolean :deleted,      null: false, default: false

      t.timestamps null: false
    end
  end
end
