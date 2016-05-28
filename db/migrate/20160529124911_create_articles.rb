class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user,            limit: 4,    null: false
      t.string     :title,           limit: 100,  null: false
      t.text       :body,            limit: 1000, null: false
      t.string     :registered_date, limit: 8,    null: false
      t.string     :updated_date,    limit: 8,    null: false
      t.integer    :lock_version,    null: false, default: 0
      t.boolean    :deleted,         null: false, default: false

      t.timestamps null: false
    end
  end
end
