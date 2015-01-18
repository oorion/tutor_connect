require_relative '../test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test 'a new visitor can create a new user' do
    visit new_user_path
    fill_in 'user[username]', with: 'example'
    fill_in 'user[first_name]', with: 'orion'
    fill_in 'user[last_name]', with: 'osborn'
    select 'teacher', :from => 'user[role]'
    fill_in 'user[zipcode]', with: '80219'
    fill_in 'user[email]', with: 'example@test.com'
    fill_in 'user[availability]', with: 'weekdays after 5pm'
    fill_in 'user[password]', with: 'foobar1234'
    fill_in 'user[password_confirmation]', with: 'foobar1234'
    fill_in 'user[subjects]', with: "Science, Math"
    click_link_or_button('Create User')
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
    click_link_or_button('Create User')
    user = User.find_by(username: 'example')
    assert_equal new_user_path, current_path
    within('#flash_error') do
      assert page.has_content?('Invalid username or password')
    end
  end
end
