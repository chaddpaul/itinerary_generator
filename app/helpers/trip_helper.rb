module TripHelper

  TRIP_TYPES = {
    "1" => ["bakery","cafe","restaurant","department_store","library","museum","park","spa"],
    "2" => ["cafe","restaurant","casino","embassy","library","shopping_mall"],
    "3" => ["church","mosque","place_of_worship","museum","zoo","restaurant","bakery","park"],
    "4" => ["amusement_park","bowling_alley","aquarium","movie_theater","museum","stadium","zoo","park"]
  }

  def find_lat_and_long(place)
    location = Geocoder.search(place)[0]
    return {latitude: location.latitude, longitude: location.longitude}
  end

  def build_url_for(place, type)
    query_parameters = "?" + URI.encode_www_form({
      location: "#{place[:latitude]},#{place[:longitude]}",
      radius: 500,
      types: TRIP_TYPES[type].join("|"),
      key: ENV["GOOGLESERVERAPIKEY"]
    })
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json" + query_parameters;
  end

  def retrieve_itinerary_info(place, type)
    geocoded_place = find_lat_and_long(place)
    request = build_url_for(geocoded_place, type)
    # TODO handle 0 resuts better
    HTTParty.get(request)
  end

end
