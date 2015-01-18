module IntegrationTestHelper
  attr_reader :user

  def setup
    @user = User.create(username: 'example',
                        password: "foobar12",
                        first_name:'Brandon',
                        last_name: 'Smith',
                        email: "Brandon@gmail.com",
                        zipcode: "80227",
                        role: "teacher",
                        school: "Turing",
                        availability: "All Day Tuesday")

    @user.subjects.create(name: "Math")
    @user.subjects.create(name: "Science")
    visit login_path
    fill_in 'session[username]', with: 'example'
    fill_in 'session[password]', with: 'foobar12'
    click_link_or_button('Login')
  end
end
