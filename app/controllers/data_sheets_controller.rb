class DataSheetsController < ApplicationController

  def index
    @racks = StorageRack.where(current: true, location: current_user.location) 
    @location = current_user.location
    @clone_feed = CloneFeed.where(location: current_user.location).first
    if @clone_feed.nil? == true
      redirect_to edit_clone_feed_path
    else
      if @clone_feed.date != DateTime.now.midnight
        redirect_to edit_clone_feed_path
      end
    end
  end

  def new
    @data_sheets = DataSheet.new
    @tray = Tray.find(params[:tray])
  end

  def create
    @data_sheet = DataSheet.new(data_sheet_params)
    @location = current_user.location
    @tray = Tray.find(data_sheet_params[:tray_id])
    if Strain.where(name: data_sheet_params[:strain_id]) != []
      @data_sheet.strain = Strain.where(name: data_sheet_params[:strain_id]).first
    else
      @data_sheet.strain = Strain.create(name: data_sheet_params[:strain_id])     
    end
    @data_sheet.location_id = @location.id
    @data_sheet.tray_id = @tray.id
    @data_sheet.storage_rack_id = @tray.storage_rack.id
    @data_sheet.status = "In Progress"
    @data_sheet.total_clone_count = @data_sheet.starting_total_clone_number
    if @data_sheet.save
      @data_entry = DataEntry.new
      @data_entry.location_id = @location.id
      @data_entry.data_sheet_id = @data_sheet.id
      @data_entry.date = DateTime.now.midnight
      @data_entry.day_count = 1
      @data_entry.shift = "AM"
      @data_entry.fed = false
      @data_entry.user_id = current_user.id
      @data_entry.note = data_sheet_params[:note]
      if @data_entry.save
        redirect_to new_data_entry_path(@data_sheet)
      end
    else
      redirect_to new_data_sheet_index_path(@tray)
    end
  end

  def watering_que
    @data_sheets = DataSheet.where(status: "Watering", location: current_user.location)
    @watering_que = []
    @data_sheets.each do |data_sheet|
      @watering_que << data_sheet.data_entries.last
    end
  end

  def transplanting_que
    @data_sheets = DataSheet.where(status: "Transplanting", location: current_user.location)
    @transplanting_que = []
    @locations_for_strains = []
    @data_sheets.each do |data_sheet|
      if @transplanting_que.include?(data_sheet.strain.name) == false
        @data_sheets.where(strain: data_sheet.strain).each do |data_sheet_locations|
          if @locations_for_strains.include?(data_sheet_locations.storage_rack.name + data_sheet_locations.tray.name.to_s) == false
            @locations_for_strains << data_sheet_locations.storage_rack.name + data_sheet_locations.tray.name.to_s
          end
        end
        @transplanting_que << [data_sheet.strain.name, @data_sheets.where(strain: data_sheet.strain).sum(:total_clone_count), @locations_for_strains]
      end
    end
    @transplanting_que = @transplanting_que.uniq
  end

  def update_transplanting_que
    @data_sheet = DataSheet.find(params[:data_sheet])
    @data_sheet.status = "Transplanting"
    @data_sheet.save
    redirect_to transplanting_que_path
  end

  def update_transplanted
    @data_sheet = DataSheet.where(strain: Strain.where(name: params[:strain].to_i))
    @data_sheet.each do |data_sheet|
      data_sheet.current = false
      data_sheet.status = "Completed"
      data_sheet.save
    end
    redirect_to transplanting_que_path
  end

  def kill_tray
    @data_sheet = DataSheet.find(params[:data_sheet])
    @data_sheet.status = "Completed"
    @data_sheet.current = false
    @data_sheet.marked_for_outlier = true
    @data_sheet.total_clone_count = 0
    @data_sheet.save
    redirect_to data_sheet_index_path
  end
  
  def mark_sheet_for_outlier
    @data_sheet = DataSheet.find(params[:data_sheet])
    @data_sheet.marked_for_outlier = true
    @data_sheet.save
    redirect_to new_data_entry_path(@data_sheet)  
  end

  def data_sheet_params
    params.require(:data_sheet).permit(:strain_id, :total_clone_count, :initial_soak_weight, :tray_id, :starting_total_clone_number, :note)
  end

end
