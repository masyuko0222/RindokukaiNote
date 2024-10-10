# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  test 'The initial display shows opening reading_clubs orderd by updated_at desc' do
    user = users(:user1)
    user.participating_reading_clubs.destroy_all

    visit_with_auth(reading_clubs_path, user)

    assert_selector 'h1', text: '輪読会一覧'

    per_page = ReadingClub.default_per_page
    start_number = 20
    end_number = start_number - per_page + 1
    expected_titles = (end_number..start_number).to_a.reverse.map { |i| "OpenClub #{i}" } # OpenClub 20..5

    titles = page.all('ul li').map(&:text)

    assert_equal expected_titles, titles
  end
end
