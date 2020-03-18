class HostsController < ApplicationController
  before_action :authenticate_user!

  def update
    @host = current_user.host
    if @host.update(host_params)
      flash[:success] = "Host updated!"
    end

    redirect_to root_path
  end

  private

  def host_params
    params.require(:host).permit(:address_1, :state, :zipcode, :name)
  end
end
