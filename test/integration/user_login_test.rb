require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user

  def setup
    @user = User.create(username: 'example', password: 'password1')
  end

  test 'the user can login' do
    visit login_path
    fill_in 'session[username]', with: 'example'
    fill_in 'session[password]', with: 'password1'
    click_link_or_button('Login')
    within '#banner' do
      assert page.has_content?('Welcome example')
    end
    within '#flash_notice' do
      assert page.has_content?('Login successful')
    end
  end

  test 'user cannot login with invalid credentials' do
    visit login_path
    fill_in 'session[username]', with: nil
    fill_in 'session[password]', with: nil
    click_link_or_button('Login')
    within '#flash_error' do
      assert page.has_content?('Invalid Login')
    end
  end
end
