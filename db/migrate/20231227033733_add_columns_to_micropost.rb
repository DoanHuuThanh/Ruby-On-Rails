class AddColumnsToMicropost < ActiveRecord::Migration[7.1]
  def change
    add_column :microposts, :parent_comment_id, :integer
    add_column :microposts, :parent_comply_id, :integer
    add_column :microposts, :content_comment, :text

    add_index :microposts, :parent_comment_id
    add_index :microposts, :parent_comply_id
    add_index :microposts, %i[parent_comply_id parent_comment_id], unique: true
  end
end
