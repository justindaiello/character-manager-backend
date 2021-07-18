require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:test_user) do
    User.create(
      name: 'Dalton Rhode',
      email: 'dalton@patron.com',
      password: 'b00tdagger'
    )
  end
  let(:token) { JWT.encode({ user_id: test_user.id }, ENV['APP_SECRET']) }

  describe 'fetching all users' do
    before do
      User.create(
        name: 'Camus Moongem',
        email: 'camus@books.com',
        password: 'iheartb00ks'
      )
    end

    context 'when the user is not authenticated' do
      it 'returns a 401 response' do
        get api_v1_users_path

        expect(response).to have_http_status(401)
      end
    end

    context 'when the user is autenticated' do
      let(:headers) { { 'Authorization': "Bearer #{token}" } }

      before do
        get api_v1_users_path, headers: headers
      end

      it 'returns a 200 on success' do
        expect(response).to have_http_status(200)
      end

      it 'responds with JSON' do
        expect(JSON.parse(response.body)).to include(hash_including('name' => 'Camus Moongem'))
      end
    end
  end
end
