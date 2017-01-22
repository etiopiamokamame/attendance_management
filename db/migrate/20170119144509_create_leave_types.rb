class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.string  :content
      t.integer :display_order
      t.string  :aggregate_display, null: false, limit: 1, default: 1
      t.string  :status,            null: false, limit: 3, default: "001"
      t.integer :lock_version,      null: false, default: 0
      t.string  :deleted,           null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
