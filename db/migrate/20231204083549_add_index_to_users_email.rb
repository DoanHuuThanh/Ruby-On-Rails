# frozen_string_literal: true

<<<<<<< HEAD
=======
# This migration change the users table.
>>>>>>> comment3
class AddIndexToUsersEmail < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :email, unique: true
  end
end
