require_relative '../test_helper'
require_relative 'integration_test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include IntegrationTestHelper

  test 'user can view subjects' do
    assert page.has_content?('Brandon Smith')
    assert page.has_content?('Brandon@gmail.com')
    assert page.has_content?('80227')
    assert page.has_content?('teacher')
    assert page.has_content?('All Day Tuesday')
    assert page.has_content?('Math')
    assert page.has_content?('Science')
  end

  test 'user can edit their info' do
    click_link_or_button('Edit Details')
    assert_equal edit_user_path(user), current_path
    fill_in 'user[username]', with: 'example1'
    fill_in 'user[password]', with: 'testing1234'
    fill_in 'user[password_confirmation]', with: 'testing1234'
    fill_in 'user[first_name]', with: 'example2'
    fill_in 'user[last_name]', with: 'example3'
    fill_in 'user[email]', with: 'example4@gmail.com'
    fill_in 'user[zipcode]', with: '99999'
    select 'tutor', :from => 'user[role]'
    fill_in 'user[availability]', with: 'only mondays'
    click_link_or_button('Update User')
    # lets not forget to also test subjects

    edited_user = User.find_by(username: 'example1')
    assert_equal 'example1', edited_user.username
    assert_equal 'example2', edited_user.first_name
    assert_equal 'example3', edited_user.last_name
    assert_equal 'example4@gmail.com', edited_user.email
    assert_equal '99999', edited_user.zipcode
    assert_equal 'tutor', edited_user.role
    assert_equal 'only mondays', edited_user.availability
  end
end
