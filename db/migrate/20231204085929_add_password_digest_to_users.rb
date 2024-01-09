# frozen_string_literal: true

# This migration change the users table.
class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
  end
end
