class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_one_attached :image
  validate :content_or_image_present
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :image, content_type: {
    in: %w[image/jpeg image/gif image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }

  def content_or_image_present
    if content.blank? && !image.attached?
      errors.add(:base, "Content or image must be present")
    elsif !content.blank? && content.length > 2000
      errors.add(:content, "cannot exceed 2000 characters")
    end
  end
end
