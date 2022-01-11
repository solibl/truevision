class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_data_sheets_watering_que, :get_data_sheets_transplanting_que
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
  end

  def get_data_sheets_watering_que
    if user_signed_in?
      @data_sheets_watering_que = DataSheet.where(status: "Watering", location: current_user.location)
    else
      @data_sheets_watering_que = []
    end
  end

  def get_data_sheets_transplanting_que
    if user_signed_in?
      @data_sheets_transplanting_que = DataSheet.where(status: "Transplanting", location: current_user.location)
    else
      @data_sheets_transplanting_que = []
    end
  end
end
