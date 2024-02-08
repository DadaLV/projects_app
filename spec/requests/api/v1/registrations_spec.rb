require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe 'POST /api/v1/sign_up' do
    context 'with valid parameters' do
      let(:valid_params) { { user: { email: 'test@example.com', password: 'password123' } } }

      it 'registers a new user' do
        post '/api/v1/sign_up', params: valid_params

        expect(response).to have_http_status(:created)
        expect(json_response['message']).to eq('User registered successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { email: '', password: '' } } }

      it 'returns unprocessable entity status' do
        post '/api/v1/sign_up', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        post '/api/v1/sign_up', params: invalid_params

        expect(json_response['errors']).to include("Email can't be blank")
        expect(json_response['errors']).to include("Password can't be blank")
      end
    end
  end
end
