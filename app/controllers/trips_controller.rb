class TripsController < ApplicationController
  include TripHelper

  def index
    @num_days = params["numOfDays"].to_i
    data = retrieve_itinerary_info(params[:location])if params[:location]
    respond_to do |format|
      format.html
      format.json {render json: data}
    end
  end

end
