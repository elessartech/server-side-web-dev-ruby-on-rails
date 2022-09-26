# frozen_string_literal: true

class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers,
           dependent: :destroy
  has_many :ratings,
           through: :beers
  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  def to_s
    name
  end
end
