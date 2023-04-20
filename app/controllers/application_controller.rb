class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :brands_shapes_color

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username, :email, :password, :password_confirmation])
  end
  
  private

  def brands_shapes_color
    @brands = Brand.all
    @shapes = Shape.all
    @colors = Color.all
  end
end
