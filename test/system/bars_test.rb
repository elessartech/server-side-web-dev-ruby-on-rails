# frozen_string_literal: true

require 'application_system_test_case'

class BarsTest < ApplicationSystemTestCase
  setup do
    @bar = bars(:one)
  end

  test 'visiting the index' do
    visit bars_url
    assert_selector 'h1', text: 'Bars'
  end

  test 'should create bar' do
    visit bars_url
    click_on 'New bar'

    fill_in 'Name', with: @bar.name
    click_on 'Create Bar'

    assert_text 'Bar was successfully created'
    click_on 'Back'
  end

  test 'should update Bar' do
    visit bar_url(@bar)
    click_on 'Edit this bar', match: :first

    fill_in 'Name', with: @bar.name
    click_on 'Update Bar'

    assert_text 'Bar was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Bar' do
    visit bar_url(@bar)
    click_on 'Destroy this bar', match: :first

    assert_text 'Bar was successfully destroyed'
  end
end
