class SendEmailJob < ActiveJob::Base
	queue_as :default

	def perform(book_perform, owner)
		ReservationMailer.booking_email(book_person, owner).deliver_now
	end
end		