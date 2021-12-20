class DataEntriesController < ApplicationController

  def new
    @data_sheet = DataSheet.find(params[:data_sheet])
    @data_entries = @data_sheet.data_entries.order(:id)
    @last_data_entry = @data_entries.last
    @new_data_entry = DataEntry.new
    @list_of_data_sheets_incomplete = DataSheet.where(current: true)
    @next_data_sheet = []
    if !@list_of_data_sheets_incomplete.nil? 
      @list_of_data_sheets_incomplete.each do |data_sheet|
        if data_sheet.data_entries.where(date: DateTime.now.midnight).count < current_user.location.entry_per_day
          @next_data_sheet << data_sheet
        end
      end
    end
    @entry_limit = false
    if @data_entries.where(date: DateTime.now.midnight).count >= current_user.location.entry_per_day
      @entry_limit = true
    end
  end

  def create
    @data_sheet = DataSheet.find(params[:data_sheet])
    @last_data_entry = @data_sheet.data_entries.order(:id).last
    @new_data_entry = DataEntry.new(data_entries_params)
    @new_data_entry.user = current_user
    @new_data_entry.location_id = current_user.location_id
    @new_data_entry.data_sheet = @last_data_entry.data_sheet
    @new_data_entry.date = DateTime.now.midnight
    if @last_data_entry.date.today? == true
      @new_data_entry.day_count = @last_data_entry.day_count
      @new_data_entry.shift = "PM"
    else
      @new_data_entry.day_count = @last_data_entry.day_count + 1
      @new_data_entry.shift = "AM"
    end
    if @last_data_entry.fed == true && @last_data_entry.weight_after_feed != nil
      @new_data_entry.gram_difference = @last_data_entry.weight_after_feed - @new_data_entry.weight
    else
      if @last_data_entry.weight != nil
        if (@last_data_entry.weight - @new_data_entry.weight) < 0
          @new_data_entry.gram_difference = nil 
        else
          @new_data_entry.gram_difference = @last_data_entry.weight - @new_data_entry.weight
        end
      else 
        @new_data_entry.gram_difference = nil
      end
    end
    @current_clone_feed = CloneFeed.where(location: current_user.location).first
    @new_data_entry.clone_feed_ph = @current_clone_feed.clone_feed_ph
    @new_data_entry.clone_feed_ec = @current_clone_feed.clone_feed_ec
    if @new_data_entry.day_count > current_user.location.total_hood_days
      @new_data_entry.has_hood = false
    end
    if @last_data_entry.grown_roots == true
      @new_data_entry.grown_roots = true
    end
    if @new_data_entry.number_of_plants_killed > 0
      @new_data_entry.data_sheet.total_clone_count -= @new_data_entry.number_of_plants_killed
    end
    if @new_data_entry.day_count <= 13 && @new_data_entry.grown_roots_less_than_inch == false
      @value_of_minimum_feed = CloneFeedSchedule.where(clone_feed_day: @new_data_entry.day_count, clone_feed_plant_number: @new_data_entry.data_sheet.total_clone_count).first.minimum_feed_weight
    elsif @new_data_entry.day_count > 13 && @new_data_entry.grown_roots_less_than_inch == false
      @value_of_minimum_feed = CloneFeedSchedule.where(clone_feed_day: 13, clone_feed_plant_number: @new_data_entry.data_sheet.total_clone_count).first.minimum_feed_weight
    elsif @new_data_entry.grown_roots_less_than_inch == true && @new_data_entry.grown_roots_greater_than_inch == false
      @value_of_minimum_feed = CloneFeedSchedule.where(clone_feed_day: 14, clone_feed_plant_number: @new_data_entry.data_sheet.total_clone_count).first.minimum_feed_weight
    elsif @new_data_entry.grown_roots_less_than_inch == true && @new_data_entry.grown_roots_greater_than_inch == true
      @value_of_minimum_feed = CloneFeedSchedule.where(clone_feed_day: 15, clone_feed_plant_number: @new_data_entry.data_sheet.total_clone_count).first.minimum_feed_weight    
    end
    if @new_data_entry.weight <= @value_of_minimum_feed && @new_data_entry.weight != nil
      @new_data_entry.fed = true
      @new_data_entry.data_sheet.status = "Watering"
    end
    if @new_data_entry.save
      @new_data_entry.data_sheet.save
      redirect_to new_data_entry_path(@data_sheet)
    end
  end

  def update
  end

  def data_entries_params
    params.require(:data_entry).permit(:weight, :number_of_plants_killed, :grown_roots, :note, :grown_roots_less_than_inch, :grown_roots_greater_than_inch, :weight_after_feed)
  end
end
