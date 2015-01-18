class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
    redirect_to root unless @user
  end

  def new
    @user = User.new()
  end

  def create
    User.create(user_params)
    @user = User.find_by(username: params[:user][:username])

    if @user
      params[:user][:subjects].split(',').each do |subject|
        @user.subjects.create(name: subject.strip)
      end
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = 'Invalid username or password'
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(session[:user_id])
    redirect_to login_path unless @user
  end

  def update
    old_user = User.find(params[:id])
    @user = User.update(old_user.id, user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 :password_confirmation,
                                 :first_name,
                                 :last_name,
                                 :zipcode,
                                 :email,
                                 :role,
                                 :availability)
  end
end
