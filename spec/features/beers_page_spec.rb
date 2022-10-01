require 'rails_helper'

describe "Beers page" do
  describe "addition" do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "works when values are valid" do
        visit new_beer_path
        fill_in('beer_name', with:"Iso 3")

        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "doesnt work when values are invalid and the notification is shown" do
        visit new_beer_path
        fill_in('beer_name', with:"")

        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(0)
    end

  end
end