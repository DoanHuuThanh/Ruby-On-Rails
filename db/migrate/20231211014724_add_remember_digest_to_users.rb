# frozen_string_literal: true

# This migration change the users table.
class AddRememberDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :remember_digest, :string
  end
end
