# frozen_string_literal: true

# Migration ChangeNullConstraintForConversationInYourModel
class ChangeNullConstraintForConversationInYourModel < ActiveRecord::Migration[7.1]
  def change
    change_column_null :messages, :conversation_id, true
  end
end
