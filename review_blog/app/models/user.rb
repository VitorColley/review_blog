class User < ApplicationRecord
  # Uses has_secure_password for password hashing and authentication
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Normalises email address before validation
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  # Added password complexity validation
  validates :password, presence: true, length: { 
    minimum: 12, 
    maximum: 64, 
    message:  'must be at least 12 characters'
    }, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).+\z/,
    message: 'must include at least one lowercase letter, one uppercase letter, one digit, and one special character'
  }
  

  def admin?
    self.admin
  end
end
