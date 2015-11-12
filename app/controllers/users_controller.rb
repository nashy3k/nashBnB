class UsersController < Clearance::UsersController

before_action :set_current_user, only: [:edit, :update, :show]
# before_action :set_auth_hash, only: [:create]

  def create
    @user = user_from_params
    @user.login_social = 0

    if @user.save
      sign_in @user
      redirect_to '/'
    else
      render template: 'users/new'
    end 
  end 

  def show
    render template: 'users/show' 
  end 

  def edit
    render template: 'users/edit' 
  end 

  def update
    @user.update_attributes(user_params)    
    @user.save
    redirect_to '/'
  end 

  private

  def set_current_user
    @user = current_user
  end 

  # def set_auth_hash
  #   @user.auth_hash = []
  # end 


  def user_from_params
    name = user_params.delete(:name)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.first_name = first_name
      user.last_name = last_name
      user.email = email
      user.password = password
    end
  end

  def user_params
    if params[:user]
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
    else
      Hash.new
    end
  end
end