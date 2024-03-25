class ApplicationController < ActionController::Base
  include Internationalization
  include Passwordless::ControllerHelpers # <-- This!
  before_action :set_locale

  helper_method :current_user
  #before_action :set_locale

  

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user
    save_passwordless_redirect_location!(User) # <-- this one!
    redirect_to root_path, flash: { error: "You are not worthy!" }
  end

  private

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  #   Rails.logger.debug("Current locale: #{I18n.locale}")
  #   Rails.logger.debug("Contents of ar.yml: #{I18n.backend.translations[:ar]}")
  # end
  # if I18n.available_locales.include?(params[:locale]&.to_sym)
  #   I18n.locale = params[:locale]
  #   Rails.logger.debug("Current locale: #{I18n.locale}")
  #   Rails.logger.debug("Contents of ar.yml: #{I18n.backend.translations[:ar]}")
  # else
  #   redirect_to "/#{I18n.default_locale}"
  # end
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
