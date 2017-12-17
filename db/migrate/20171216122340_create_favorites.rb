class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.bigint :user_id, null: false
      t.bigint :article_id, null: false

      t.timestamps
    end

    add_index :favorites, :article_id
    add_index :favorites, [:user_id, :article_id], unique: true
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :articles
  end
end
