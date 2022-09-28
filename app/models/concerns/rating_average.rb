# frozen_string_literal: true

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    scores = ratings.map(&:score)
    (scores.sum / scores.length).to_f unless ratings.empty?
  end
end
