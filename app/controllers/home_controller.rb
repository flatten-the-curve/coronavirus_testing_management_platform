class HomeController < ApplicationController
  def index
    @user = current_user
    @host = current_user&.host
    if @host
      @current_host_marker = [{
        "lat": @host.latitude,
        "lng": @host.longitude,
        "infowindow": "<div>#{@host.name}<br><a target='_blank' href='#{@host.google_maps_url}'>Route me here!</a></div>"
      }].to_json.html_safe
      @patient_counts = @host.patient_count_today
      @line_counts = @host.line_count_today
    end
    @all_markers = []
    Host.all.each do |h|
      @all_markers.push(
        {
          "lat": h.latitude,
          "lng": h.longitude,
          "infowindow": "<div>#{h.name}<br><a target='_blank' href='#{h.google_maps_url}'>Route me here!</a></div>"
        }
      )
    end
    @all_markers = @all_markers.to_json.html_safe
  end
end
