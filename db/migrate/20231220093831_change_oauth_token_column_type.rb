# frozen_string_literal: true

class ChangeOauthTokenColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :oauth_token, :text
  end
end
