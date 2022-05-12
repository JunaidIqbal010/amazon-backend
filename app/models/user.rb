class User < ApplicationRecord
  has_secure_token :token
  has_many :orders, dependent: :destroy
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :cart, dependent: :destroy
end
