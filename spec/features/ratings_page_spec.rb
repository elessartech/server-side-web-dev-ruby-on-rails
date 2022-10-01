# frozen_string_literal: true

require 'rails_helper'

describe 'Ratings page' do
  describe 'displays' do
    it 'no ratings when they are not created' do
      visit ratings_path
      expect(page).to have_content 'List of ratings'
      expect(page).to have_content 'Number of ratings: 0'
    end

    it 'ratings properly when they are created' do
      user = FactoryBot.create(:user)
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer:, user:)
      visit ratings_path
      expect(page).to have_content 'List of ratings'
      expect(page).to have_content 'Number of ratings: 1'
      expect(page).to have_content 'anonymous 20'
    end
  end
end
