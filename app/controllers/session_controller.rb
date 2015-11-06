class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by(email: params[:login][:email])
		if @user && @user.authenticate(params[:login][:password])
			session[:user_id] = @user.id
			login(@user)
			redirect_to @user
		else
			flash[:error] = "Email or password is invalid"
			#render :new #flash wont work at render the page
			redirect_to new_login_path
		end
		
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
