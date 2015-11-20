json.array!(@listings) do |listing|
  json.extract! listing, :id, :title

	json.user_id listing.user_id
  json.start listing.availability_start_date
  json.end listing.availability_end_date
  json.url listing_url(listing, format: :html)
end