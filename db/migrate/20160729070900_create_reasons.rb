class CreateReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :reasons do |t|
      t.string  :content
      t.integer :lock_version, null: false, default: 0
      t.string  :deleted,      null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
