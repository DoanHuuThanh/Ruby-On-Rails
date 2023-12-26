class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  # một phương thức được sử dụng trong Rails để kết nối một tệp đính kèm (attachment) với một mô hình.
  # Thường được sử dụng với Active Storage
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200, miniumum: 5 }
  validates :image, content_type: {
    in: %w[image/jpeg image/gif image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }
end
