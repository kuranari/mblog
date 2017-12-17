class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_token :api_token

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :crypted_password, presence: true
  validates :password, length: { minimum: 8 }, if: -> { changes[:crypted_password] }
end
