require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test 'a new visitor can create a new user' do
    visit new_user_path
    fill_in 'user[username]', with: 'example'
    fill_in 'user[password]', with: 'foobar1234'
    fill_in 'user[password_confirmation]', with: 'foobar1234'
    click_link_or_button('Create An Account')
    user = User.find_by(username: 'example')
    assert_equal user_path(user), current_path
    within('#banner') do
      assert page.has_content?('Welcome example')
    end
  end

  test 'a new visitor cannot create a new user with a short password' do
    visit new_user_path
    fill_in 'user[username]', with: 'example'
    fill_in 'user[password]', with: 'foo'
    fill_in 'user[password_confirmation]', with: 'foo'
    click_link_or_button('Create An Account')
    user = User.find_by(username: 'example')
    assert_equal new_user_path, current_path
    within('#flash_error') do
      assert page.has_content?('Invalid username or password')
    end
  end
end
