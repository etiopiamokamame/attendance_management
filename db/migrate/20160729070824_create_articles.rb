class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :user,               limit: 4,    null: false
      t.string     :title,              limit: 100,  null: false
      t.text       :body,               limit: 1000, null: false
      t.integer    :posted_start_year,  null: false
      t.integer    :posted_start_month, null: false
      t.integer    :posted_start_day,   null: false
      t.integer    :posted_end_year,    null: false
      t.integer    :posted_end_month,   null: false
      t.integer    :posted_end_day,     null: false
      t.integer    :lock_version,       null: false, default: 0
      t.string     :deleted,            null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
