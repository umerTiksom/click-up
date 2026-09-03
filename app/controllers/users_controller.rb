class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new,:create]
  def new
    redirect_to home_path if authenticated?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user)
      redirect_to home_path, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
