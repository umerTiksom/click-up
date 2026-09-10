class ApplicationController < ActionController::Base
  before_action :redirect_if_logged_in
  include Pundit::Authorization
  include Authentication
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def pundit_user
    Current.user
  end
  private

  def redirect_if_logged_in
    if session[:user_id].present?
      redirect_to home_path, alert: "You are already logged in"
    end
  end
  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action"
    redirect_to root_path
  end
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
