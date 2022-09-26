# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :beer
  def to_s
    'tekstiesitys'
  end
end
