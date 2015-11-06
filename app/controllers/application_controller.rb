class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # include ApplicationHelper

  private
    def authenticate_user!
      flash[:notice] = "Please login first"
      redirect_to root_path unless user_logged_in?
    end

end
