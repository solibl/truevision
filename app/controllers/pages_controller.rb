class PagesController < ApplicationController
  
  def home
    if not user_signed_in?
      redirect_to user_session_path
    end
    @next_data_sheet = []
    if !@list_of_data_sheets_incomplete.nil? 
      @list_of_data_sheets_incomplete.each do |data_sheet|
        if data_sheet.data_entries.where(date: DateTime.now.midnight).count < current_user.location.entry_per_day
          @next_data_sheet << data_sheet
        end
      end
    end
    if user_signed_in?
      @clone_feed = CloneFeed.where(location: current_user.location).first
      if @clone_feed.nil? == false
        if @clone_feed.date != DateTime.now.midnight
          @clone_feed_done_today = false
        end
      end
    end
  end

end
