# frozen_string_literal: true

# This migration change the micropost table.
class AddParentIdToMicroposts < ActiveRecord::Migration[7.1]
  def change
    add_column :microposts, :parent_id, :integer
    add_index :microposts, :parent_id
  end
end
