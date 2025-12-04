class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :title, presence: true
  validates :body, presence: true
end
