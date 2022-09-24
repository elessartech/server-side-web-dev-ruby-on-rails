class Rating < ApplicationRecord
    belongs_to :beer
end

class Brewery < ApplicationRecord
    has_many :ratings
end