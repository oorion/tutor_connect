require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has valid attributes" do
    user = User.create(username: 'example',
                       password: "foobar12",
                       first_name:'Brandon',
                       last_name: 'FKJDSF',
                       email: "Brandon@gmail.com",
                       zipcode: "80227",
                       role: "teacher",
                       school: "Turing",
                       availability: "All Day Tuesday")
    user.subjects.create(name: "Math")
    user.subjects.create(name: "Science")
    assert_equal 'example', user.username
    assert_equal 'foobar12', user.password
    assert_equal 'Brandon', user.first_name
    assert_equal 'FKJDSF', user.last_name
    assert_equal 'Brandon@gmail.com', user.email
    assert_equal '80227', user.zipcode
    assert_equal 'teacher', user.role
    assert_equal 'Turing', user.school
    assert_equal 'Math', user.subjects.first.name
    assert_equal 'All Day Tuesday', user.availability
  end

  test "user cannot have invalid attributes" do
    user = User.create(username: nil, password: nil)
    refute user.valid?
  end

  test "user cannot skip signup" do
    user = User.create(username: "Rolando", password: "12345678A")
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
