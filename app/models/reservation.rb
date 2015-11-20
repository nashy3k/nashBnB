class Reservation < ActiveRecord::Base
scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }

validates :user_id, presence: true
validates :listing_id, presence: true

belongs_to :user
belongs_to :listing

end	