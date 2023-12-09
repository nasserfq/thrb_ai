class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers # <-- This!
  helper_method :current_user

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user

    # save_passwordless_redirect_location!(User) # <-- optional, see below
    redirect_to root_path, flash: { error: 'You are not worthy!' }
  end
end
