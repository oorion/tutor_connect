class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end

  def new

  end

  def create
    User.create(username: params[:user][:username],
                password: params[:user][:password])
    @user = User.find_by(username: params[:user][:username])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = 'Invalid username or password'
      redirect_to new_user_path
    end
  end
end
