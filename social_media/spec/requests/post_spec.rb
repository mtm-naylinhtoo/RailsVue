require 'rails_helper'

RSpec.describe "Posts", type: :request do
  def token_generator(user_id)
    JWT.encode({ sub: user_id }, Rails.application.credentials.devise_jwt_secret_key!)
  end
  
  def json
    JSON.parse(response.body)
  end
  let(:user) { create(:user) }
  let(:token) { token_generator(user.id) }
  let(:headers) { { 'Authorization': "Bearer #{token}" } }
  let(:valid_attributes) { { post: { title: 'Test Title', body: 'Test Body' } } }

  describe "GET /posts" do
    it "returns all posts" do
      create_list(:post, 10, user: user)
      get posts_path, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end
  end

  describe "GET /posts/:id" do
    let(:post) { create(:post, user: user) }

    it "returns the post" do
      get post_path(post), headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(post.id)
    end
  end

  describe "POST /posts" do
    it "creates a new post" do
      expect {
        post posts_path, params: valid_attributes, headers: headers
      }.to change(Post, :count).by(1)
    end

    it "returns a created status" do
      post posts_path, params: valid_attributes, headers: headers
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /posts/:id" do
    let(:post) { create(:post, user: user) }
    let(:new_attributes) { { post: { title: 'Updated Title', body: 'Updated Body' } } }

    it "updates the post" do
      put post_path(post), params: new_attributes, headers: headers
      post.reload
      expect(post.title).to eq('Updated Title')
      expect(post.body).to eq('Updated Body')
    end

    it "returns an ok status" do
      put post_path(post), params: new_attributes, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /posts/:id" do
    let!(:post) { create(:post, user: user) }

    it "deletes the post" do
      expect {
        delete post_path(post), headers: headers
      }.to change(Post, :count).by(-1)
    end

    it "returns a no content status" do
      delete post_path(post), headers: headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
