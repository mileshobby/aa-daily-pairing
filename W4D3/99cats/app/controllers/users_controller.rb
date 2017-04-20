class UsersController < ApplicationController
  before_action :check_login_status, only: [:new, :create]

  def check_login_status
    if current_user
      flash[:errors] = ["Already logged in"]
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      login_user!
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
