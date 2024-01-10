# frozen_string_literal: true

# This migration AddIndex the users table.
class AddIndexToUsersEmail < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :email, unique: true
  end
end
