class AddUniqueConstraintToReactions < ActiveRecord::Migration[7.1]
  def change
    add_index :reactions, [:user_id, :micropost_id], unique: true
  end
end