class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user
  # Returns the currently logged-in user based on session info
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in."
    end
  end

    #Logic to restrict review editing/deleting to owner or admin(Least Privilege Principle)
  def require_owner_or_admin
    # Allow if current_user is admin
    return if current_user&.admin?

    # Allow if current_user owns the record
    if @review.user != current_user
      redirect_to @review, alert: "You are not authorized to perform this action."
    end
  end
end
