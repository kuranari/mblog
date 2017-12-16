class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.bigint :user_id, null: false, index: true

      t.timestamps
    end
    add_foreign_key :articles, :users
  end
end
