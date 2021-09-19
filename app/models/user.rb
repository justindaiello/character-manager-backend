class User < ApplicationRecord
  has_secure_password

  has_many :characters, dependent: :destroy

  accepts_nested_attributes_for :characters

  validates :name, presence: true

  validates :password, length: { minimum: 8 }

  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
end
