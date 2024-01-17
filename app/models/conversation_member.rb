# frozen_string_literal: true

# Model ConversationMember
class ConversationMember < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates_uniqueness_of :user_id, scope: :conversation_id
end
