# frozen_string_literal: true

# Model ConversationMember
class ConversationMember < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
end
