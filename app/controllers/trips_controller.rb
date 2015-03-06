class TripsController < ApplicationController
  include TripHelper

  def index
    @num_days = params["numOfDays"].to_i
    @trip_type = params["trip_type"]
    data = retrieve_itinerary_info(params[:location], params["trip_type"]) if params[:location]
    respond_to do |format|
      format.html
      format.json { render json: data }
    end
  end

end
