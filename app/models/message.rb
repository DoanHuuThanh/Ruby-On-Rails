# frozen_string_literal: true

# Model Message
class Message < ApplicationRecord
  belongs_to :user
  has_one_attached :audio_file
  validates :content, presence: true
end
