class ApplicationController < ActionController::API
  # @see https://github.com/heartcombo/devise#strong-parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken
  include DeviseHackFakeSession

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name email tel postal address password type])
  end
end
