class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.location = current_user.location
    if !@user.first_name.nil? || !@user.last_name.nil?
      @user.initials = @user.first_name[0].capitalize + @user.last_name[0].capitalize
    end
    @user.authorization_level = "Employee"
    if @user.save
      redirect_to root_path, notice: "User has been created."
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
