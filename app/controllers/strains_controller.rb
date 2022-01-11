class StrainsController < ApplicationController
  def index
    @strains_names = Strain.all.order(:name).pluck(:name).uniq
    @strains = Strain.all
  end

  def info
    @strain = Strain.find(params[:strain])
    @data_sheets = @strain.data_sheets.order(:id)
    @current_data_sheets = @data_sheets.where(current: true)
    @active_count = @data_sheets.where(current: true).sum(:total_clone_count)
    @best_dryback = @data_sheets.where(marked_for_outlier: false).where.not(first_initial_dry_back: nil).order(:first_initial_dry_back).first
    @best_average_gram_difference = @data_sheets.where(marked_for_outlier: false).where.not(average_gram_difference: nil).order(:average_gram_difference).first
    @locations_for_strains = []
    @first_day_roots = @data_sheets.average(:first_day_roots)
    if @current_data_sheets.any? == true
      @current_data_sheets.each do |data_sheet|
        if @locations_for_strains.include?(data_sheet.storage_rack.name + data_sheet.tray.name.to_s) == false
          @locations_for_strains << data_sheet.storage_rack.name + data_sheet.tray.name.to_s
        end
      end
    end
  end

end
