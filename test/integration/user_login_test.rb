require 'test_helper'
require_relative 'integration_test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include IntegrationTestHelper

  test 'the user can login' do
    within '#banner' do
      assert page.has_content?('Welcome example')
    end
    within '#flash_notice' do
      assert page.has_content?('Login successful')
    end
    assert_equal user_path(user), current_path
  end

  test 'user cannot login with invalid credentials' do
    visit login_path
    fill_in 'session[username]', with: 'blah'
    fill_in 'session[password]', with: 'sdfasdffasdf1221'
    click_link_or_button('Login')
    within '#flash_error' do
      assert page.has_content?('Invalid Login')
    end
  end
end
