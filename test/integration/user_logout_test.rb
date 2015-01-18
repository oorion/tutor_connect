require 'test_helper'
require_relative 'integration_test_helper'

class UserLogoutTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include IntegrationTestHelper

  test 'user can logout' do
    visit user_path(@user)
    click_link_or_button 'Logout'
    assert_equal login_path, current_path
    within("#flash_notice") do
      assert page.has_content?("Successfully logged out")
    end
  end
end
