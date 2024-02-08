require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  describe 'POST /api/v1/sign_in' do
    let(:user) { create :user }

    it 'signs in a user and returns token' do
      post '/api/v1/sign_in', params: { email: user.email, password: user.password }
      
      expect(response).to have_http_status(:success)
      expect(response.headers['Authorization']).to be_present
    end
    
    it 'returns unauthorized status with invalid credentials' do
      post '/api/v1/sign_in', params: { email: 'invalid@example.com', password: 'invalidpassword' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
    
  describe 'POST /api/v1/sign_out' do
    let(:user) { create :user }

    it 'signs out the user' do
      post '/api/v1/sign_in', params: { email: user.email, password: user.password }

      delete '/api/v1/sign_out', headers: { 'Authorization' => response.headers['Authorization'] }

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Signed out successfully')
    end

    it 'returns unauthorized status for unauthorized request' do
      delete '/api/v1/sign_out'

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
