# frozen_string_literal: true

# Model Conversation
class Conversation < ApplicationRecord
  has_many :conversation_members, dependent: :destroy
  has_many :messages, class_name: 'Message', foreign_key: 'conversation_id', dependent: :destroy
  validates :name, presence: true
end
