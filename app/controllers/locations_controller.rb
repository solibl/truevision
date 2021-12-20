class LocationsController < ApplicationController
	
  def edit
		@location = current_user.location
	end

  def update
    @location = current_user.location
    if @location.update(location_params)
      create_racks_and_trays(@location)
      edit_total_racks(@location)
      redirect_to root_path, notice: "Location has been updated."
    # Handle a successful update.
    else
      render 'edit'
    end
  end
  
  def create_racks_and_trays(location)
    rack_names = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    rack_counter = 1
    needed_racks = location.total_rack.to_i
    needed_trays = location.total_tray_per_rack.to_i
    while rack_counter <= needed_racks
      current_rack = StorageRack.where(location: @location, name: rack_names[rack_counter-1])
      if current_rack.any? == true
        current_rack.update(current: true) 
        total_number_of_trays = Tray.where(location: @location, storage_rack: current_rack).count
        if total_number_of_trays == nil
          total_number_of_trays = 0
        end
        if needed_trays <= total_number_of_trays
          counter = 1
          while counter <= total_number_of_trays
            if needed_trays >= counter
              tray_edit = Tray.where(location: @location, storage_rack: current_rack, name: counter.to_s)
              if tray_edit.any?
                tray_edit.update(current: true)
                counter += 1
              end
            else
              tray_edit = Tray.where(location: @location, storage_rack: current_rack, name: counter.to_s)
              if tray_edit.any?
                tray_edit.update(current: false)
                counter += 1
              end
            end
          end
        end
        if total_number_of_trays < needed_trays
          while total_number_of_trays < needed_trays
            total_number_of_trays += 1
            Tray.create(current: true, location: @location, storage_rack: current_rack.first, name: total_number_of_trays.to_s)
          end
        end
      else
        total_number_of_trays = 0
        current_rack = StorageRack.create(current: true, location: @location, name: rack_names[rack_counter-1])
        while total_number_of_trays < needed_trays
          total_number_of_trays += 1
          Tray.create(current: true, location: @location, storage_rack: current_rack, name: total_number_of_trays.to_s)
        end
      end
    rack_counter += 1
    end
  end

  def edit_total_racks(location)
    rack_names = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    total_current_racks = StorageRack.where(location: @location, current: true).count
    if total_current_racks > location.total_rack.to_i
      while total_current_racks > location.total_rack.to_i
        current_rack = StorageRack.where(current: true, location: @location, name: rack_names[total_current_racks-1])
        current_rack.update(current: false)
        total_current_racks -= 1
      end
    end
  end

  def location_params
    params.require(:location).permit(:name, :total_rack, :total_tray_per_rack, :trays_per_storage_row, :total_hood_days, :entry_per_day)
  end

end
