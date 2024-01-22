# frozen_string_literal: true

class UidToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string
  end
end
