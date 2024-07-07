class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_post, only: [:update, :destroy]
  respond_to :json

  # GET /posts
  # Request: GET /posts
  # Headers: Authorization: Bearer <token>
  # Response:
  # 200 OK
  # [
  #   {
  #     "id": 1,
  #     "title": "Post Title",
  #     "body": "Post Body",
  #     "user_id": 1,
  #     "created_at": "2023-01-01T00:00:00.000Z",
  #     "updated_at": "2023-01-01T00:00:00.000Z"
  #   },
  #   ...
  # ]
  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  # GET /posts/:id
  # Request: GET /posts/:id
  # Headers: Authorization: Bearer <token>
  # Response:
  # 200 OK
  # {
  #   "id": 1,
  #   "title": "Post Title",
  #   "body": "Post Body",
  #   "user_id": 1,
  #   "created_at": "2023-01-01T00:00:00.000Z",
  #   "updated_at": "2023-01-01T00:00:00.000Z"
  # }
  # 404 Not Found
  # {
  #   "error": "Post not found"
  # }
  def show
    render json: @post, status: :ok
  end

  # POST /posts
  # Request: POST /posts
  # Headers: Authorization: Bearer <token>
  # Parameters: 
  # {
  #   "post": {
  #     "title": "New Post",
  #     "body": "Post Body"
  #   }
  # }
  # Response:
  # 201 Created
  # {
  #   "id": 1,
  #   "title": "New Post",
  #   "body": "Post Body",
  #   "user_id": 1,
  #   "created_at": "2023-01-01T00:00:00.000Z",
  #   "updated_at": "2023-01-01T00:00:00.000Z"
  # }
  # 422 Unprocessable Entity
  # {
  #   "errors": ["Error message"]
  # }
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /posts/:id
  # Request: PUT /posts/:id
  # Headers: Authorization: Bearer <token>
  # Parameters: 
  # {
  #   "post": {
  #     "title": "Updated Title",
  #     "body": "Updated Body"
  #   }
  # }
  # Response:
  # 200 OK
  # {
  #   "id": 1,
  #   "title": "Updated Title",
  #   "body": "Updated Body",
  #   "user_id": 1,
  #   "created_at": "2023-01-01T00:00:00.000Z",
  #   "updated_at": "2023-01-02T00:00:00.000Z"
  # }
  # 401 Unauthorized
  # {
  #   "error": "Not Authorized"
  # }
  # 422 Unprocessable Entity
  # {
  #   "errors": ["Error message"]
  # }
  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  # Request: DELETE /posts/:id
  # Headers: Authorization: Bearer <token>
  # Response:
  # 204 No Content
  # 401 Unauthorized
  # {
  #   "error": "Not Authorized"
  # }
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
