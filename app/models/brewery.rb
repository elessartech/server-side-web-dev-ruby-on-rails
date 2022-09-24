class Beer < ApplicationRecord
    belongs_to :brewery
end
  
class Brewery < ApplicationRecord
    has_many :beers
    def restart
        self.year = 2022
        puts "changed year to #{year}"
    end
end