require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end


  describe "with an improper password" do
    let(:user){ User.create username: "Pekka", password: "w1W", password_confirmation: "w1W" }
    let(:user){ User.create username: "Maksim", password: "qwerty", password_confirmation: "qwerty" }

    it "is not saved when password is too short" do
      expect(user).to be_invalid
      expect(User.count).to eq(0)
    end

    it "is not saved when password consists of only small characters" do
      expect(user).to be_invalid
      expect(User.count).to eq(0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      beer1 = FactoryBot.create(:beer)
      beer2 = FactoryBot.create(:beer)
      beer3 = FactoryBot.create(:beer)
      rating1 = FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
      rating2 = FactoryBot.create(:rating, score: 25, beer: beer2, user: user)
      rating3 = FactoryBot.create(:rating, score: 9, beer: beer3, user: user)
    
      expect(user.favorite_beer).to eq(beer2)
    end
  end
  describe "the application" do
    it "does something with two users" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user, username: "Vilma")
    end
  end
  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end
  end
end