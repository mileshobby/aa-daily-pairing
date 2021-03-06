class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :foo

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!
    session[:session_token] = @user.session_token
  end

  def logout_user
    current_user.reset_session_token!
    session[:session_token] = nil
  end


end
