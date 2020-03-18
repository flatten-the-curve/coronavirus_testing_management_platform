class HomeController < ApplicationController
  def index
    @user = current_user
    @host = current_user&.host
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
    Host.where.not(latitude: nil, longitude: nil).each do |h|
      @all_markers.push(
        {
          "lat": h.latitude,
          "lng": h.longitude,
          "infowindow": "<div>#{h.name}<br><b>Currently In Line: #{h.line_count_today}</b><br><a target='_blank' href='#{h.google_maps_url}'>Route me here!</a></div>",
          "icon": "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=1|FE6256|000000"
        }
      )
    end
    @all_markers = @all_markers.to_json.html_safe
  end
end
