# frozen_string_literal: true

# This migration change the users table.
class AddResetToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
