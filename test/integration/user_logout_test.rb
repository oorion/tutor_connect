require 'test_helper'

class UserLogoutTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

   attr_reader :user
  # def setup
  #   @user = User.create(username: "foo", password: "foobar13", password_confirmation: "foobar13")
  # end

  test 'user can logout' do
    @user = User.create(username: "foo", password: "foobar13", password_confirmation: "foobar13")
    visit user_path(@user)
    click_link_or_button 'Logout'
    assert_equal login_path, current_path
    within("#flash_notice") do
      assert page.has_content?("Successfully logged out")
    end
  end
end
