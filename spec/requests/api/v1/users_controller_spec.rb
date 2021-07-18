require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:test_user) { create(:user) }
  let(:token) { JWT.encode({ user_id: test_user.id }, ENV['APP_SECRET']) }

  describe 'fetching all users' do
    before do
      create(:user)
    end

    context 'when the user is not authenticated' do
      it 'returns a 401 response' do
        get api_v1_users_path

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
      end
    end

    context 'when the user is autenticated' do
      let(:headers) { { 'Authorization': "Bearer #{token}" } }

      it 'responds with JSON' do
        get api_v1_users_path, headers: headers

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
