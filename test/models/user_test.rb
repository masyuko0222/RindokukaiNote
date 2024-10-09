# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @exist_user_info = OmniAuth::AuthHash.new(
      {
        provider: 'discord',
        uid: '12345678',
        info: {
          name: 'TestMan'
        }
      }
    )

    @new_user_info = OmniAuth::AuthHash.new(
      {
        provider: 'discord',
        uid: '987654321',
        info: {
          name: 'NewTestMan'
        }
      }
    )
  end

  test '#find_or_create_from_discord_info is used as find method if user is exist' do
    oauth_user = User.find_or_create_from_discord_info(@exist_user_info)
    exist_user = users(:user1)

    assert_equal oauth_user, exist_user
  end

  test '#find_or_create_from_discord_info is used as create method if user is new' do
    assert_difference 'User.count', +1 do
      oauth_user = User.find_or_create_from_discord_info(@new_user_info)

      assert_equal 'discord', oauth_user.provider
      assert_equal '987654321', oauth_user.uid
      assert_equal 'NewTestMan', oauth_user.name
    end
  end

  test '.participating_open_clubs' do
    user = users(:user1)

    r1 = reading_clubs(:reading_club1)
    r3 = reading_clubs(:reading_club3)
    r20 = reading_clubs(:reading_club20)

    [r1, r3, r20].each do |r|
      user.participants.create!(reading_club: r)
    end

    assert_equal 3, user.participating_open_clubs.count
    assert_equal [r20, r3, r1], user.participating_open_clubs.first(3) # 後から参加したものが先頭にくる
  end
end
