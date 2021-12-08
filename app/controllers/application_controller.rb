class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_data_sheets_watering_que, :get_data_sheets_transplanting_que
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
  end

  def get_data_sheets_watering_que
    @data_sheets_watering_que = DataSheet.where(status: "Watering")
  end

  def get_data_sheets_transplanting_que
    @data_sheets_transplanting_que = DataSheet.where(status: "Transplanting")
    
  end
end
