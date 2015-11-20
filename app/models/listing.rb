class Listing < ActiveRecord::Base
scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }

validates :title, presence: true
validates :location, presence: true

belongs_to :user
has_many :reservations

end	