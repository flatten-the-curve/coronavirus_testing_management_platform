class AddressSearchController < ApplicationController

  def index
    search_results = ["No Results Found"]
    if params["search_value"].present?
      search_results = get_parsed_results
    end
    render json: search_results
  end

  private

  def get_parsed_results
    Geocoder.search(params["search_value"]).map {|result| "#{result.house_number} #{result.street}, #{result.city}, #{result.state}, #{result.postal_code}"}
  end
end
