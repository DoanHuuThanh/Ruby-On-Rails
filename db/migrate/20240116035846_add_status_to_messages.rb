# frozen_string_literal: true

# Migration AddStatusToMessages.
class AddStatusToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :status, :string
  end
end
