class ApplicationController < ActionController::Base
  before_action :redirect_if_logged_in
  include Pundit::Authorization
  include Authentication
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
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
