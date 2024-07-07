class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_user_function, only: [:update, :destroy]
  respond_to :json

  # GET /users
  # Request: GET /users
  # Headers: Authorization: Bearer <token>
  # Response:
  # 200 OK
  # [
  #   {
  #     "id": 1,
  #     "name": "John Doe",
  #     "email": "john@example.com",
  #     "created_at": "2023-01-01T00:00:00.000Z",
  #     "updated_at": "2023-01-01T00:00:00.000Z"
  #   },
  #   ...
  # ]
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/:id
  # Request: GET /users/:id
  # Headers: Authorization: Bearer <token>
  # Response:
  # 200 OK
  # {
  #   "id": 1,
  #   "name": "John Doe",
  #   "email": "john@example.com",
  #   "created_at": "2023-01-01T00:00:00.000Z",
  #   "updated_at": "2023-01-01T00:00:00.000Z",
  #   "posts": [
  #     {
  #       "id": 1,
  #       "title": "Post Title",
  #       "body": "Post Body",
  #       "created_at": "2023-01-01T00:00:00.000Z",
  #       "updated_at": "2023-01-01T00:00:00.000Z"
  #     },
  #     ...
  #   ]
  # }
  def show
    render json: @user, include: 'posts', status: :ok
  end

  # PUT /users/:id
  # Request: PUT /users/:id
  # Headers: Authorization: Bearer <token>
  # Parameters: 
  # {
  #   "user": {
  #     "name": "Updated Name",
  #     "email": "updated@example.com",
  #     "password": "newpassword"
  #   }
  # }
  # Response:
  # 200 OK
  # {
  #   "id": 1,
  #   "name": "Updated Name",
  #   "email": "updated@example.com",
  #   "created_at": "2023-01-01T00:00:00.000Z",
  #   "updated_at": "2023-01-02T00:00:00.000Z"
  # }
  # 422 Unprocessable Entity
  # {
  #   "errors": ["Error message"]
  # }
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  # Request: DELETE /users/:id
  # Headers: Authorization: Bearer <token>
  # Response:
  # 204 No Content
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def authorize_user_function
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @user.id == current_user.id
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
