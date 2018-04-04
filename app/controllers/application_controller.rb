class ApplicationController < ActionController::Base
  layout :dynamic_layout
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email password password_confirmation avatar])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def dynamic_layout
    if user_signed_in?
      'application'
    else
      'guest'
    end
  end
end
