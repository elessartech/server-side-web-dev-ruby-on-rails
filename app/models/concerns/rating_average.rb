# frozen_string_literal: true

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    scores = ratings.map(&:score)
    unless ratings.empty?
      (scores.sum / scores.length).to_f
    end
  end
end
