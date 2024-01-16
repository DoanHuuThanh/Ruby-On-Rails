# frozen_string_literal: true

# Migration CreateConversationMembers
class CreateConversationMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
    add_index :conversation_members, %i[user_id conversation_id], unique: true
  end
end
