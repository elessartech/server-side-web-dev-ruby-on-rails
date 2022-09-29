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
end
