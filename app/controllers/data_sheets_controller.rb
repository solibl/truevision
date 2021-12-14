class DataSheetsController < ApplicationController

  def index
    @racks = StorageRack.where(current: true) 
    @location = current_user.location

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
      @data_entry.date = DateTime.now.strftime("%m/%d/%Y")
      @data_entry.day_count = 1
      @data_entry.shift = "AM"
      @data_entry.fed = "N/A"
      @data_entry.user_id = current_user.id
      if @data_entry.save
        redirect_to new_data_entry_path(@data_sheet)
      end
    else
      redirect_to new_data_sheet_index_path(@tray)
    end

  end

  def data_sheet_params
    params.require(:data_sheet).permit(:strain_id, :total_clone_count, :initial_soak_weight, :tray_id, :starting_total_clone_number)
  end

end
