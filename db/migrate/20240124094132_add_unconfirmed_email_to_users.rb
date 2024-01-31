# frozen_string_literal: true

# migration AddUnconfirmedEmailToUsers
class AddUnconfirmedEmailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :unconfirmed_email, :string
  end
end