module ApplicationHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    !current_user.nil?
  end
end
