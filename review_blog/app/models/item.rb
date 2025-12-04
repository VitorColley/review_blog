class Item < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
end

