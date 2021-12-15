class DataEntriesController < ApplicationController

  def new
    @data_sheet = DataSheet.find(params[:data_sheet])
    @data_entries = @data_sheet.data_entries.order(:id)
  end
end
