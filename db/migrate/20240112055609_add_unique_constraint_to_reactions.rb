# frozen_string_literal: true

# Migration AddUniqueConstraintToReactions
class AddUniqueConstraintToReactions < ActiveRecord::Migration[7.1]
  def change
    add_index :reactions, %i[user_id micropost_id], unique: true
  end
end
