class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart_count

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :mobile ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :mobile ])
  end

  def set_cart_count
    @cart_count = current_user.cart&.total_items || 0
  end
end
