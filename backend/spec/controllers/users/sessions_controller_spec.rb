# spec/controllers/users/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  let(:user) { create(:user) }

  describe 'POST #create (login)' do
    it 'returns JWT token and user data on successful login' do
      post '/login', params: { user: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response['status']['code']).to eq(200)
      expect(json_response['status']['message']).to eq('Logged in successfully.')
      expect(json_response['status']['token']).not_to be_nil
      expect(json_response['status']['data']['user']['email']).to eq(UserSerializer.new(user).serializable_hash[:data][:attributes][:email])
      expect(response.headers['Authorization']).not_to be_nil
    end


    it "return status 401 if credentials are wrong" do
      post "/login", params: {user:{email:"invalid@gmail.com",password:"password"}}

      expect(response).to have_http_status(401)
    end


  end

  describe 'DELETE #destroy (logout)' do

    context 'with a valid JWT token' do
      before do
        post '/login', params: { user: { email: user.email, password: 'password' } }
        @token = JSON.parse(response.body)['status']['token']
      end

      it 'logs out successfully with valid token' do
        delete '/logout', headers: { 'Authorization' => "Bearer #{@token}" }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        expect(json_response['status']).to eq(200)
        expect(json_response['message']).to eq('Logged out successfully.')
      end
    end

    context 'without a valid session (no token)' do
      it 'returns unauthorized error' do
        delete '/logout'

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)

        expect(json_response['status']).to eq(401)
        expect(json_response['message']).to eq("Couldn't find an active session.")
      end
    end
  end
end
