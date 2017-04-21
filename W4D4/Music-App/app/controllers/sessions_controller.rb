class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
    params[:user][:email],
    params[:user][:password]
    )
    if @user.nil?
      flash[:errors] = ["Incorrect email/password"]
      redirect_to new_sessions_url
    else
      log_in_user!(@user)
      redirect_to user_url(@user)
    end
  end

  def new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_sessions_url
  end

end
