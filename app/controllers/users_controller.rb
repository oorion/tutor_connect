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
      @user.update_subjects(params[:user][:subjects])
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
    @user = User.update(params[:id], user_params)
    @user.update_subjects(params[:user][:subjects])
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
