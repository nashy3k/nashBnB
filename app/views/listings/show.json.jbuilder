json.array!(@listingW) do |l|	
	json.(l, :id, :title, :user_id)
  json.start l.availability_start_date
  json.end l.availability_end_date	
  json.url listing_url(l, format: :html)
end 