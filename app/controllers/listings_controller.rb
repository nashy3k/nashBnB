class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = listing_from_params

    if @listing.save
      @notice = "Listing created!"
      redirect_to listings_path, :notice => @notice
    else
      render template: 'listings/new'
    end 
  end 

  def show
    @listingW = Listing.where(id: params[:id])
    @listing = Listing.find(params[:id])
    @listings = Listing.this_month
  end 

  def edit
    @listing = Listing.find(params[:id])
  end 

  def index
    @listing = Listing.all
    @listings = Listing.this_month
    @reservation = Reservation.this_month
    # @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end 

  def index_user
    @listing = Listing.where(user_id: current_user)
    render template: 'listings/index'
  end 

  def update
    @listing.update_attributes(user_params)    
    @listing.save
    redirect_to '/'
  end 

  def destroy
    @listing = Listing.find(params[:id])
    if @listing.user_id = current_user.id
    @listing.destroy
    @notice = "Listing deleted!"
    else
    @notice = "Listing delete not permitted!"     
    end
    redirect_to listings_path, :notice => @notice
  end 
  
  private

  def listing_from_params
    title = listing_params.delete(:title)
    location = listing_params.delete(:location)
    about = listing_params.delete(:about)
    accomodates = listing_params.delete(:accomodates)
    bathrooms = listing_params.delete(:bathrooms)
    bed_type = listing_params.delete(:bed_type)
    bedrooms = listing_params.delete(:bedrooms)
    beds = listing_params.delete(:beds)
    check_in = listing_params.delete(:check_in)
    check_out = listing_params.delete(:check_out)
    smoking = listing_params.delete(:smoking)
    pets = listing_params.delete(:pets)
    kitchen = listing_params.delete(:kitchen)
    tv = listing_params.delete(:title)
    internet = listing_params.delete(:internet)
    wifi = listing_params.delete(:wifi)
    free_parking = listing_params.delete(:free_parking)
    family_friendly = listing_params.delete(:family_friendly)
    suitable_events = listing_params.delete(:suitable_events)
    prices = listing_params.delete(:prices)
    weekly_discount = listing_params.delete(:weekly_discount)
    monthly_discount = listing_params.delete(:monthly_discount)
    cancellation = listing_params.delete(:cancellation)
    description = listing_params.delete(:description)
    availability_start_date = listing_params.delete(:availability_start_date)
    availability_end_date = listing_params.delete(:availability_end_date)
    safety_features = listing_params.delete(:safety_features)
    pictures_url = listing_params.delete(:pictures_url)

    Listing.new(listing_params).tap do |l|
      l.user_id = current_user.id
      l.title = title
      l.location = location
      l.about = about
      l.accomodates = accomodates
      l.bathrooms = bathrooms
      l.bed_type = bed_type
      l.bedrooms = bedrooms
      l.beds = beds
      l.check_in = check_in
      l.check_out = check_out
      l.smoking = smoking
      l.pets = pets
      l.kitchen = kitchen
      l.tv = title
      l.internet = internet
      l.wifi = wifi
      l.free_parking = free_parking
      l.family_friendly = family_friendly
      l.suitable_events = suitable_events
      l.prices = prices
      l.weekly_discount = weekly_discount
      l.monthly_discount = monthly_discount
      l.cancellation = cancellation
      l.description = description
      l.availability_start_date = availability_start_date
      l.availability_end_date = availability_end_date
      l.safety_features = safety_features
      l.pictures_url = pictures_url
    end
  end

    def listing_params
    if params[:listing]
      params.require(:listing).permit(:title, :location, :about, :accomodates, :bathrooms, :bed_type, :bedrooms, :beds, :check_in, :check_out, :smoking, :pets, :kitchen, :tv, :internet, :wifi, :free_parking, :family_friendly, :suitable_events, :prices, :weekly_discount, :monthly_discount, :cancellation, :description, :availability_start_date, :availability_end_date, :safety_features, :pictures_url)
    else
      Hash.new
    end
  end

end
