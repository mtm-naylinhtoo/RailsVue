class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]
	before_action :authorize_user_function, only: [:update, :destroy]
  respond_to :json

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, include: 'posts', status: :ok
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

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
