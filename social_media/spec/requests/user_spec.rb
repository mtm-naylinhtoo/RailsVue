require 'rails_helper'

RSpec.describe "Users", type: :request do

  def token_generator(user_id)
    payload = { sub: user_id, jti: SecureRandom.uuid, scp: 'user' }  # Example: 'scp' claim set to 'user'
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!)
  end

  let(:user) { create(:user) }
  
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
    before { user } # create user before running the test

    let(:valid_attributes) { { user: { email: user.email, password: user.password } } }

    it "logs in the user" do
      post '/login', params: valid_attributes
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /logout" do
    it "logs out the user" do
      delete '/logout', headers: { 'Authorization': "Bearer #{token_generator(user.id)}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
