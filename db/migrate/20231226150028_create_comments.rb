class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
    add_index :comments, :parent_id
    add_index :comments, %i[user_id micropost_id created_at], unique: true
  end
end
