# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :receiver
      t.integer :conversation_id
      t.string :status

      t.timestamps
    end
  end
end
