# frozen_string_literal: true

# This migration change the users table.
class AddActivationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :activated, :boolean, default: false
  end
end
