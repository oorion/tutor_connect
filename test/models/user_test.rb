require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has valid attributes" do
    user = User.create(username: 'example', password: "foobar12")
    assert_equal 'example', user.username
    assert_equal 'foobar12', user.password
  end

  test "user cannot have invalid attributes" do
    user = User.create(username: nil, password: nil)
    refute user.valid?
  end

  test "user needs a strong password" do
    user = User.create(username: 'example', password: "foo")
    refute user.valid?
  end

  test 'password must contain numbers and letters' do
    user1 = User.create(username: 'example', password: "foooooobar")
    user2 = User.create(username: 'example', password: "1232131231")
    refute user1.valid?
    refute user2.valid?
  end
end
