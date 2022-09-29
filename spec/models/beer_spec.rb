require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with all required attributes provided" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }
    it "is saved" do
      expect(test_beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
  describe "with not all required attributes provided" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer_1) { Beer.create style: "teststyle", brewery: test_brewery }
    let(:test_beer_2) { Beer.create name: "testbeer", brewery: test_brewery }
    it "is not saved when name is not assigned" do
      expect(test_beer_1).to be_invalid
      expect(Beer.count).to eq(0)
    end
    it "is not saved when style is not assigned" do
      expect(test_beer_2).to be_invalid
      expect(Beer.count).to eq(0)
    end
  end
  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end
  describe "when one beer exists" do
    let(:beer){FactoryBot.create(:beer)}
  
    it "is valid" do
      expect(beer).to be_valid
    end
  
    it "has the default style" do
      expect(beer.style).to eq("Lager")
    end
  end
end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end