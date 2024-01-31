# frozen_string_literal: true

# Migration AddRememberTokenToUSers
class AddRememberTokenToUSers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :remember_token, :string
  end
end
