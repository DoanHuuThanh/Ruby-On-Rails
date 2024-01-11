# frozen_string_literal: true

# Model Rection
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates_uniqueness_of :user_id, scope: :micropost_id
  enum action: { like: 0, love: 1, haha: 2, wow: 3, sad: 4, angry: 5 }
end
