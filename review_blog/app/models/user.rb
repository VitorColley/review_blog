class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def authenticate(password)
    self.password == password
  end

  def admin?
    self.admin
  end
end
