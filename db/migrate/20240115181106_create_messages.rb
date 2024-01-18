# frozen_string_literal: true

# Migration CreateMessages.
class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :receiver
      t.integer :conversation_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
