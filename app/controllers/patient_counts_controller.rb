class PatientCountsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @patient_count = current_user.host.patient_counts.new(patient_params)
    if @patient_count.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def patient_params
    params.require(:patient_count).permit(:amount)
  end
end
