class HomeController < ApplicationController
  def index
    @user = current_user
    @host = current_user&.host
    @patient_counts = @host.patient_counts.sum(:amount)
  end
end
