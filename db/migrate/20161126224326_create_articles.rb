class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :user,                   limit: 4
      t.string     :title,                  limit: 100
      t.text       :body,                   limit: 1000
      t.string     :posted_start_date_ymd,  limit: 8
      t.string     :posted_end_date_ymd,    limit: 8
      t.integer    :lock_version,           default: 0
      t.string     :deleted,                limit: 1, default: 0

      t.timestamps
    end
  end
end
