class ProfileController < ApplicationController
  def show
    @user = Current.user
  end

  def edit
  @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(profile_params)
      redirect_to home_path, notice: 'Profile was successfully updated...'
    else
    render :edit, status: :unprocessable_entity
    end
  end
end
