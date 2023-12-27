# frozen_string_literal: true

# Model Micropost
class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :comments, class_name: 'Micropost', foreign_key: 'parent_id', dependent: :destroy
  has_many :replies, class_name: 'Micropost', foreign_key: 'parent_id', dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :image, content_type: {
    in: %w[image/jpeg image/gif image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }
end
