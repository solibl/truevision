class LocationsController < ApplicationController
	def edit
		@location = current_user.location
	end

  def update
    @location= current_user.location
    if @location.update(location_params)
      redirect_to root_path, notice: "Location has been updated."
    # Handle a successful update.
    else
    render 'edit'
    end
  end

  def location_params
    params.require(:location).permit(:total_rack, :total_tray_per_rack, :total_hood_days)
  end
end
