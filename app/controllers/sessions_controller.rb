class SessionsController < Clearance::SessionsController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    elsif user = User.find_by(email: auth_hash["info"]["email"])
      authentication.update_token(auth_hash)
      authentication.update_attributes(user_id: user.id)        
      @next = root_url
      @notice = "Signed in! User exists"
    else
      user = User.create_with_auth_and_hash(authentication,auth_hash,1)
      @next = edit_user_path(user)   
      @notice = "User created - confirm or edit details..."
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end

  def user_params
    if params[:user]
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :user_id)
    else
      Hash.new
    end
  end
end