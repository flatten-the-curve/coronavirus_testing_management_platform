class HomeController < ApplicationController
  def index
    @user = current_user
    @host = current_user&.host
    set_current_location
    if @host
      set_host_info
    end
    set_all_markers
  end

  private

  def set_host_info
    @current_host_marker = [{
      "lat": @host.latitude,
      "lng": @host.longitude,
      "infowindow": "<div>#{@host.name}<br><a target='_blank' href='#{@host.google_maps_url}'>Route me here!</a></div>"
    }].to_json.html_safe
    @patient_counts = @host.patient_count_today
    @line_counts = @host.line_count_today
  end

  def set_all_markers
    @all_markers = []
    lat = [32.7490..34.7490]
    lon = [-85.3880..-83.3880]
    if @current_location.present?
      new_lat = @current_location.data["lat"].to_f
      new_lon = @current_location.data["lon"].to_f
      lat = [(new_lat - 1)..(new_lat + 1)]
      lon = [(new_lon - 1)..(new_lon + 1)]
    end
    Host.where(latitude: lat, longitude: lon).each do |h|
      @all_markers.push(
        {
          "lat": h.latitude,
          "lng": h.longitude,
          "infowindow": "<div>#{h.name}<br><b>Currently In Line: #{h.line_count_today}</b><br><a target='_blank' href='#{h.google_maps_url}'>Route me here!</a></div>",
        }
      )
    end
    @all_markers = @all_markers.to_json.html_safe
  end

  def set_current_location
    @map_center = {
      lat: 33.7490,
      lng: -84.3880
    }.to_json.html_safe
    if params["address_search"]
      @current_location = Geocoder.search(params["address_search"]).first
    elsif request&.location&.address.present?
      @current_location = Geocoder.search(request.location.address).first
    end
    if @current_location.present?
      @map_center = {
        lat: @current_location.data["lat"].to_f,
        lng: @current_location.data["lon"].to_f
      }.to_json.html_safe
    end
  end
end
