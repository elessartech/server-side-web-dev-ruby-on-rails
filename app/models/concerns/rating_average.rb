module RatingAverage
    extend ActiveSupport::Concern
  
    def average_rating
      scores = ratings.map{|rating| rating.score}
      return (scores.sum / scores.length).to_f if !ratings.empty?
    end
  end