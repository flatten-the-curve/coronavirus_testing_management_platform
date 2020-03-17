class LineCountsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @line_count = current_user.host.line_counts.new(line_params)
    if @line_count.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def line_params
    params.require(:line_count).permit(:amount)
  end
end
