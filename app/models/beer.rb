class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy
    def to_s
      self.name + ' | ' + self.brewery.name
    end
  end
  
  class Rating < ApplicationRecord
    belongs_to :beer
  end