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
    if @last_data_entry.date == DateTime.now.midnight
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
      if @new_data_entry.data_sheet.data_entries.where(fed: true).count == 1
        @new_data_entry.data_sheet.first_initial_dry_back = @new_data_entry.weight
        @new_data_entry.data_sheet.first_initial_dry_back_day_count = @new_data_entry.day_count
      end
      @new_data_entry.data_sheet.success_rate = (@new_data_entry.data_sheet.total_clone_count.to_f / @new_data_entry.data_sheet.starting_total_clone_number).round(2)
      @new_data_entry.data_sheet.average_gram_difference = @new_data_entry.data_sheet.data_entries.where(has_hood: false).average(:gram_difference)
      @new_data_entry.data_sheet.save
      redirect_to new_data_entry_path(@data_sheet)
    end
  end

  def update
    @data_entry = DataEntry.find(data_entries_params[:id])
    @data_entry.weight_after_feed = data_entries_params[:weight_after_feed]
    @data_entry.data_sheet.status = "In Progress"
    @data_entry.save
    @data_entry.data_sheet.save
    redirect_to watering_que_path
  end

  def edit
    @data_entry = DataEntry.find(params[:data_entry])
  end

  def edit_update
    @data_entry = DataEntry.find(data_entries_params[:id])
    @index_of_data_entries = @data_entry.data_sheet.data_entries.order(:id)
    @placing_of_last_data_entry = @index_of_data_entries.find_index(@data_entry)
    @last_data_entry = @index_of_data_entries[@placing_of_last_data_entry-1]
    if !data_entries_params[:weight] == ""
      if !@last_data_entry.weight_after_feed.nil?
        @data_entry.gram_difference = @last_data_entry.weight_after_feed - data_entries_params[:weight].to_i
      else
        @data_entry.gram_difference = @last_data_entry.weight - data_entries_params[:weight].to_i
      end
      @data_entry.edited_user_initials = current_user.initials
      if @data_entry.gram_difference < 0
        @data_entry.gram_difference = nil
      end
    end
    @data_entry.update(data_entries_params)
    redirect_to new_data_entry_path(@data_entry.data_sheet)
  end

  def manual_feed
    @data_entry = DataSheet.find(params[:data_sheet]).data_entries.order(:id).last
    @data_entry.manual_feed = true
    @data_entry.fed = true
    @data_entry.data_sheet.status = "Watering"
    @data_entry.edited_user_initials = current_user.initials
    @data_entry.save
    @data_entry.data_sheet.save
    redirect_to new_data_entry_path(@data_entry.data_sheet)
  end

  def data_entries_params
    params.require(:data_entry).permit(:weight, :number_of_plants_killed, :grown_roots, :note, :grown_roots_less_than_inch, :grown_roots_greater_than_inch, :weight_after_feed, :id)
  end
end
