class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  private
  
  # Find current user from session
  def current_user
     @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user
end
