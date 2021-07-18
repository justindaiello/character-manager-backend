require 'rails_helper'

RSpec.describe Api::V1::AuthenticationsController, type: :request do
  let(:user) { create(:user) }
  let(:login_params) { { email: user.email, password: user_password } }

  describe 'user logging in' do
    context 'when the user has invalid credentials' do
      let(:user_password) { 'wrongpasswordbud' }

      it 'throws and error and returns and error message' do
        post api_v1_login_path, params: login_params

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Invalid username or password')
      end
    end

    context 'when the user has valid credentials' do
      let(:user_password) { user.password }

      it 'responds with JSON' do
        post api_v1_login_path, params: login_params

        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
