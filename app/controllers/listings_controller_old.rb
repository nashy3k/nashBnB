class ListingsController < ApplicationController::Base

  def create
    @listing = listing_from_params

    if @listing.save
      sign_in @user
      redirect_to edit_listings_path
    else
      render template: 'listing/new'
    end 
  end 

  def show
    render template: 'listing/show' 
  end 

  def edit
    render template: 'listing/edit' 
  end 

  def update
    @listing.update_attributes(user_params)    
    @listing.save
    redirect_to '/'
  end 

  private

  def user_from_params
    name = user_params.delete(:name)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    listing.new(listing_params).tap do |l|
      l.name = name
      l.first_name = first_name
      l.last_name = last_name
      l.email = email
      l.password = password
    end
  end
    def listing_params
    if params[:listing]
      params.require(:listing).permit(:title, :location, :about, :accomodates, :bathrooms, :bed_type, :bedrooms, :beds, :check_in, :check_out, :smoking, :pets, :prices, :weekly_discount, :monthly_discount, :cancellation, :description, :availability, :safety_features, :pictures_url)
    else
      Hash.new
    end
  end

end