class SessionsController < ApplicationController
  before_action :check_login_status, only: [:new, :create]

  def check_login_status
    if current_user
      flash[:errors] = ["Already logged in"]
      redirect_to cats_url
    end
  end

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      @user.reset_session_token!
      login_user!
      redirect_to cats_url
    else
      flash[:errors] = ["Invalid login credentials"]
      redirect_to new_sessions_url
    end
  end

  def destroy
    if current_user
      logout_user
      redirect_to cats_url
    else
      flash.now[:errors] = ["No user to destroy :("]
    end
  end
end
