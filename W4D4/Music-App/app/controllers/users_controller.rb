class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save!
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def new
    render :new
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
