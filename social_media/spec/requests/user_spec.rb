require 'rails_helper'

RSpec.describe "Users", type: :request do
  def token_generator(user_id)
    payload = { sub: user_id, jti: SecureRandom.uuid, scp: 'user' }
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!)
  end

  def json
    JSON.parse(response.body)
  end

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:token) { token_generator(user.id) }
  let(:another_token) { token_generator(another_user.id) }
  let(:headers) { { 'Authorization': "Bearer #{token}" } }
  let(:another_headers) { { 'Authorization': "Bearer #{another_token}" } }

  describe "POST /signup" do
    let(:valid_attributes) { { user: { name: 'John', email: 'test@example.com', password: 'password', password_confirmation: 'password' } } }

    it "creates a new user" do
      expect {
        post '/signup', params: valid_attributes
      }.to change(User, :count).by(1)
    end

    it "returns a successful response" do
      post '/signup', params: valid_attributes
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    before { user }

    let(:valid_attributes) { { user: { email: user.email, password: user.password } } }

    it "logs in the user" do
      post '/login', params: valid_attributes
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /logout" do
    it "logs out the user" do
      delete '/logout', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /users" do
    it "returns all users" do
      create_list(:user, 10)
      get users_path, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(11)
    end

    it "returns unauthorized status without auth header" do
      get users_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /users/:id" do
    it "returns the user" do
      get user_path(user), headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(user.id)
    end

    it "returns unauthorized status without auth header" do
      get user_path(user)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT /users/:id" do
    let(:new_attributes) { { user: { name: 'Updated Name', email: 'updated@example.com', password: 'newpassword' } } }

    it "updates the user" do
      put user_path(user), params: new_attributes, headers: headers
      user.reload
      expect(user.name).to eq('Updated Name')
      expect(user.email).to eq('updated@example.com')
    end

    it "returns an ok status" do
      put user_path(user), params: new_attributes, headers: headers
      expect(response).to have_http_status(:ok)
    end

    it "does not allow a different user to update the user" do
      put user_path(user), params: new_attributes, headers: another_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized status without auth header" do
      put user_path(user), params: new_attributes
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /users/:id" do
    it "deletes the user" do
        delete user_path(user), headers: headers
        expect(response).to have_http_status(:no_content)
        expect(User.exists?(user.id)).to be_falsey
    end

    it "returns a no content status" do
      delete user_path(user), headers: headers
      expect(response).to have_http_status(:no_content)
    end

    it "does not allow a different user to delete the user" do
      delete user_path(user), headers: another_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized status without auth header" do
      delete user_path(user)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
