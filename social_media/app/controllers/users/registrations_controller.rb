# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # POST /signup
  # Request: POST /signup
  # Parameters:
  # {
  #   "user": {
  #     "name": "John Doe",
  #     "email": "john@example.com",
  #     "password": "password",
  #   }
  # }
  # Response:
  # 200 OK
  # {
  #   "status": {
  #     "code": 200,
  #     "message": "Signed up successfully.",
  #     "token": "JWT token here",
  #     "data": {
  #       "id": 1,
  #       "name": "John Doe",
  #       "email": "john@example.com",
  #       "created_at": "2023-01-01T00:00:00.000Z",
  #       "updated_at": "2023-01-01T00:00:00.000Z"
  #     }
  #   }
  # }
  # 422 Unprocessable Entity
  # {
  #   "status": {
  #     "message": "User couldn't be created successfully. Error message here."
  #   }
  # }
  def respond_with(resource, _opts = {})
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      render json: {
        status: { code: 200, message: 'Signed up successfully.',
                  token: @token,
                  data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
  
end
