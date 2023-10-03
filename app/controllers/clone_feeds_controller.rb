class CloneFeedsController < ApplicationController
  
  def edit
    @current_clone_feed = CloneFeed.where(location: current_user.location).first
    @clone_feed = CloneFeed.new
  end

  def update
    @clone_feed = CloneFeed.where(location: current_user.location).first
    if @clone_feed.nil?
      @clone_feed = CloneFeed.new
    end
    @clone_feed.user = current_user
    @clone_feed.location = current_user.location
    @clone_feed.date = DateTime.now.midnight
    if @clone_feed.update(clone_feed_params)
      redirect_to data_sheet_index_path
    # Handle a successful update.
    else
      render 'edit'
    end
  end

  def clone_feed_params
    params.require(:clone_feed).permit(:clone_feed_ph, :clone_feed_ec, :volume_per_tray, :clone_feed_ec_roots, :clone_feed_ph_roots)
  end

end
