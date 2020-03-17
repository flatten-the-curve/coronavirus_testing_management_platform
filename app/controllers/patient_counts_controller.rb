class PatientCountsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @patient_count = current_user.host.patient_counts.new(patient_params)
    if @patient_count.save
      if total_in_line = @patient_count.host.line_count_today
        @patient_count.host.line_counts.create(patient_count_id: @patient_count.id, amount: -1) if total_in_line > 0
      end
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
