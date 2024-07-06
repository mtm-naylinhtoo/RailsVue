class ApplicationController < ActionController::API
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	private

	def authenticate_user!
	  return render json: { error: 'Not Authorized' }, status: :unauthorized unless user_signed_in?
	end
  
	def current_user
	  return unless request.headers['Authorization'].present?
  
	  token = request.headers['Authorization'].split.last
	  decoded_token = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
	  @current_user ||= User.find(decoded_token['sub'])
	rescue JWT::DecodeError
	  nil
	end
  
	def user_signed_in?
	  current_user.present?
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])

		devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
	end
end
