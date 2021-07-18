require 'rails_helper'

RSpec.describe Api::V1::AuthenticationsController, type: :request do
  let(:user) do
    User.create(
      name: 'Camus Moongem',
      email: 'camus@books.com',
      password: 'iheartb00ks'
    )
  end
  let(:login_params) { { email: user.email, password: user_password } }

  describe 'user logging in' do
    context 'when the user has invalid credentials' do
      let(:user_password) { 'wrongpasswordbud' }

      it 'throws and error and returns and error message' do
        post api_v1_login_path, params: login_params
        expect(response).to have_http_status(401)
      end
    end

    context 'when the user has valid credentials' do
      let(:user_password) { 'iheartb00ks' }

      it 'responds with JSON' do
        post api_v1_login_path, params: login_params

        expect(response).to have_http_status(201)
      end
    end
  end
end
