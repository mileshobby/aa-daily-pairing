class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    if current_user.id.to_s == params[:id]
      render text: "We are glad you are using Reddit On Rails, #{current_user.username} :) "
    else
      render text: "You can only view your own page :( "
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
