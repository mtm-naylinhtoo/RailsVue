class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :update, :destroy]
	before_action :authorize_post, only: [:update, :destroy]
  respond_to :json

	def index
	  @posts = Post.all
	  render json: @posts, status: :ok
	end
  
	def show
	  render json: @post, status: :ok
	end
  
	def create
	  @post = current_user.posts.build(post_params)
	  if @post.save
		render json: @post, status: :created
	  else
		render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
	  end
	end
  
	def update
	  if @post.update(post_params)
		render json: @post, status: :ok
	  else
		render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
	  end
	end
  
	def destroy
	  @post.destroy
	  head :no_content
	end
  
	private
  
	def set_post
	  @post = Post.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  render json: { error: 'Post not found' }, status: :not_found
	end
  
	def authorize_post
	  render json: { error: 'Not Authorized' }, status: :unauthorized unless @post.user == current_user
	end
  
	def post_params
	  params.require(:post).permit(:title, :body)
	end
  end
  