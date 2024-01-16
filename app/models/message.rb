# frozen_string_literal: true

# Model Message
class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
end
