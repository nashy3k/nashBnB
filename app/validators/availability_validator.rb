class AvailabilityValidator < ActiveModel::EachValidator

  # `each` stands for 'each attribute with a validation'
  def validate_each(record, attribute, value)
    # Args: a model instance, a symbol of attribute and a value it has
    # You also get a hash in `options`
    # If you specified validation as `availability: true`, you wouldn't get it

    reservations = Reservation.where(["listing_id =?", record.listing_id])
    date_ranges = reservations.map { |e| e.check_in_date.to_date..e.check_out_date.to_date }

    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "#{options[:name] || 'Existing booking'} date not available")
      end
    end

  end
end