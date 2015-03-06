module TripHelper

  def find_lat_and_long(place)
    location = Geocoder.search(place)[0]
    return {latitude: location.latitude, longitude: location.longitude}
  end

  def hit_api(place)
    query_parameters = "?" + URI.encode_www_form({
      location: "#{place[:latitude]},#{place[:longitude]}",
      radius: 500,
      key: ENV["GOOGLESERVERAPIKEY"]
    })
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json" + query_parameters;
  end

  def retrieve_itinerary_info(place)
    geocoded = find_lat_and_long(place)
    number_location = hit_api(geocoded)
    info_array = HTTParty.get(number_location)
  end

end
