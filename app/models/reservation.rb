class Reservation < ActiveRecord::Base
scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }

validates :user_id, presence: true
validates :listing_id, presence: true
validate :check_in_date_cannot_be_in_the_past
validate :validate_available_date, on: :create
validates :check_in_date,        # Note the comma!
  availability: true                 # ...and some other validations
validates :check_out_date,
  availability: {name: "End date"}   # same here
validates_presence_of :check_in_date, :check_out_date

belongs_to :user
belongs_to :listing


  # Check if a given interval overlaps this interval    
  def overlaps?(other)
    (self.check_in_date - other.check_out_date) * (other.check_in_date - self.check_out_date) >= 0
  end

  # Return a scope for all interval overlapping the given interval, including the given interval itself
  scope :overlapping, lambda { |interval| {
    :conditions => ["id <> ? AND (DATEDIFF(check_in_date, ?) * DATEDIFF(?, check_out_date)) >= 0", interval.id, interval.check_out_date, interval.check_in_date]
  }}

  def validate_available_date
    unless check_in_date? && check_out_date?
			errors.add(:check_in_date, "not available") 
			return false
		end
	end		

	def check_in_date_cannot_be_in_the_past
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "can't be in the past")
    end
  end

  private

  	def check_in_date?

      if self.check_in_date >  self.listing.availability_start_date && self.check_in_date <  self.listing.availability_end_date 
	    	return true
      else 
        return false
      end
    end

    def check_out_date?

      if self.check_out_date >  self.listing.availability_start_date && self.check_out_date < self.listing.availability_end_date 
      	return true
      else 
        return false
      end
    end
end	