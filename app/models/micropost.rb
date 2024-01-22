# frozen_string_literal: true

# Model Micropost
class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reactions, dependent: :destroy
  has_many :comments, class_name: 'Micropost', foreign_key: 'parent_id', dependent: :destroy
  validates :content, presence: true, length: { maximum: 2000 }
  default_scope -> { order(created_at: :desc) }
  scope :yesterday_posts, -> { where(parent_id: nil, created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day)}
  scope :yesterday_comments, -> {
    where(created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day)
      .where.not(parent_id: nil).count
  }
  validates :user_id, presence: true
  validates :image, content_type: {
    in: %w[image/jpeg image/gif image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }
end
