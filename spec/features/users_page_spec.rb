# frozen_string_literal: true

require 'rails_helper'

include Helpers

describe 'User' do
  before :each do
    FactoryBot.create :user
  end

  describe 'who has signed up' do
    it 'can signin with right credentials' do
      sign_in(username: 'Pekka', password: 'Foobar1')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it 'is redirected back to signin form if wrong credentials given' do
      sign_in(username: 'Pekka', password: 'wrong')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it 'when signed up with good credentials, is added to the system' do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect do
      click_button('Create User')
    end.to change { User.count }.by(1)
  end

  it 'can see ones own made ratings' do
    beer = FactoryBot.create(:beer)
    user = User.find_by username: 'Pekka'
    FactoryBot.create(:rating, score: 20, beer:, user:)
    sign_in(username: 'Pekka', password: 'Foobar1')
    expect(page).to have_content 'anonymous 20'
  end

  it 'can delete own ratings and they will be removed from db' do
    beer = FactoryBot.create(:beer)
    user = User.find_by username: 'Pekka'
    FactoryBot.create(:rating, score: 20, beer:, user:)
    sign_in(username: 'Pekka', password: 'Foobar1')
    expect do
      click_button('delete')
    end.to change { Rating.count }.by(-1)
  end

  it 'can see favorite brewery and style on the users page' do
    beer = FactoryBot.create(:beer)
    user = User.find_by username: 'Pekka'
    FactoryBot.create(:rating, score: 20, beer:, user:)
    sign_in(username: 'Pekka', password: 'Foobar1')
    expect(page).to have_content 'Favorite style: Lager'
    expect(page).to have_content 'Favorite brewery: anonymous'
  end
end
