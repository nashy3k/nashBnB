class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @listing = Listing.find_by(id: params[:listing_id], user_id: params[:user_id])

  end

  def create
    @listing = Listing.find(params[:reservation][:listing_id])
    existing_reservations = Reservation.where(listing_id: params[:reservation][:listing_id])
    @reservation = reservation_from_params

    overlap = false
    existing_reservations.each do |existing|
      if @reservation.overlaps?(existing)
        overlap = true
        @reservation.errors.add(:check_in_date, "Reservation failed! Date overlaps with existing reservations") 
      end
    end

    if overlap == false && @reservation.save
      @notice = "Reservation created!"
      redirect_to index_user_reservation_path, :notice => @notice
    else
      @notice = "Reservation failed!"
      render template: 'reservations/errors'
    end 
  end 

  def show
    @reservation = Reservation.find(params[:id])
  end 

  def edit
    @reservation = Reservation.find(params[:id])
  end 

  def index
    @reservation = Reservation.all
    @reservations = Reservation.this_month
  end 

  def index_user
    @reservation = Reservation.where(user_id: current_user)
    render template: 'reservations/index'
  end 

  def update
    @reservation.update_attributes(user_params)    
    @reservation.save
    redirect_to '/'
  end 

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id = current_user.id
    @reservation.destroy
    @notice = "Reservation deleted!"
    else
    @notice = "Reservation delete not permitted!"     
    end
    redirect_to reservations_path, :notice => @notice
  end 
  
  private

  def reservation_from_params
    comments = reservation_params.delete(:comments)
    guests = reservation_params.delete(:guests)
    check_in_date = reservation_params.delete(:check_in_date)
    check_out_date = reservation_params.delete(:check_out_date)
    smoking = reservation_params.delete(:smoking)
    pets = reservation_params.delete(:pets)
    kitchen = reservation_params.delete(:kitchen)
    tv = reservation_params.delete(:tv)
    internet = reservation_params.delete(:internet)
    wifi = reservation_params.delete(:wifi)
    free_parking = reservation_params.delete(:free_parking)
    family_friendly = reservation_params.delete(:family_friendly)
    suitable_events = reservation_params.delete(:suitable_events)

    Reservation.new(reservation_params).tap do |l|
      l.user_id = current_user.id
      l.listing_id = params[:reservation][:listing_id]
      l.comments = comments
      l.guests = guests
      l.check_in_date = check_in_date
      l.check_out_date = check_out_date
      l.smoking = smoking
      l.pets = pets
      l.kitchen = kitchen
      l.tv = tv
      l.internet = internet
      l.wifi = wifi
      l.free_parking = free_parking
      l.family_friendly = family_friendly
      l.suitable_events = suitable_events
    end
  end

    def reservation_params
    if params[:reservation]
      params.require(:reservation).permit(:user_id, :listing_id, :comments, :guests, :check_in_date, :check_out_date, :smoking, :pets, :kitchen, :tv, :internet, :wifi, :free_parking, :family_friendly, :suitable_events, )
    else
      Hash.new
    end
  end

end
