# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json


  private

  # POST /login
  # Request: POST /login
  # Parameters:
  # {
  #   "user": {
  #     "email": "john@example.com",
  #     "password": "password"
  #   }
  # }
  # Response:
  # 200 OK
  # {
  #   "status": {
  #     "code": 200,
  #     "message": "Logged in successfully.",
  #     "token": "JWT token here",
  #     "data": {
  #       "user": {
  #         "id": 1,
  #         "name": "John Doe",
  #         "email": "john@example.com",
  #         "created_at": "2023-01-01T00:00:00.000Z",
  #         "updated_at": "2023-01-01T00:00:00.000Z"
  #       }
  #     }
  #   }
  # }
  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        token: @token,
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    }, status: :ok
  end

  # DELETE /logout
  # Request: DELETE /logout
  # Headers: Authorization: Bearer <token>
  # Response:
  # 200 OK
  # {
  #   "status": 200,
  #   "message": "Logged out successfully."
  # }
  # 401 Unauthorized
  # {
  #   "status": 401,
  #   "message": "Couldn't find an active session."
  # }
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
  
end
