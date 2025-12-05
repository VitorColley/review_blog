class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  def authenticate(password)
    self.password == password
  end

  def admin?
    self.admin
  end
end
