class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_usuario! 
  

  # Llama al método 'configure_permitted_parameters' antes de cualquier acción de Devise (cuando se maneja el registro o inicio de sesión).
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Método que agrega los parámetros personalizados a los parámetros permitidos por Devise durante el registro.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre_usuario, :telefono, :rol])
  end
  # Alias para CanCanCan
  def current_user
    current_usuario
  end
end
