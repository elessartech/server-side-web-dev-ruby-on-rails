# frozen_string_literal: true

class User < ApplicationRecord
  include RatingAverage
  has_secure_password
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/ }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end
