module RatingAverage
    extend ActiveSupport::Concern
        def average_rating
            self.beers.map{|beer| beer.ratings.map{|rating| rating.score.to_f}}.sum
        end
   end