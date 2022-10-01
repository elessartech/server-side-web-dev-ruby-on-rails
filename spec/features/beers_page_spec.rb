# frozen_string_literal: true

require 'rails_helper'

include Helpers

describe 'Beers page' do
  describe 'addition' do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @breweries = %w[Koff Karjala Schlenkerla]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end
      FactoryBot.create :user
      sign_in(username: 'Pekka', password: 'Foobar1')
      visit new_beer_path
    end

    it 'works when values are valid' do
      fill_in('beer_name', with: 'Iso 3')

      expect do
        click_button('Create Beer')
      end.to change { Beer.count }.by(1)
    end

    it 'doesnt work when values are invalid and the notification is shown' do
      fill_in('beer_name', with: '')

      expect do
        click_button('Create Beer')
      end.to change { Beer.count }.by(0)
    end
  end
end
