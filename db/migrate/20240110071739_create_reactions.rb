# frozen_string_literal: true

# This migration creatr the reaction table.
class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.integer :action
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reactions, :action
  end
end
