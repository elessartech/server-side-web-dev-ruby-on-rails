class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings
  end
  
  class Rating < ApplicationRecord
    belongs_to :beer
  end