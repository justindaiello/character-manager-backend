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

  describe 'creating a user' do
    let(:signup_params) do
      {
        user: {
          name: 'Miley Cyrus',
          email: signup_email,
          password: 'partyinth3usa'
        }
      }
    end

    context 'when there are invalid or missing params' do
      let(:signup_email) { nil }

      it 'does not allow a character to be created' do
        post api_v1_sign_up_path, params: signup_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)[0]).to eq('Email is invalid')
      end
    end

    context 'when all params are valid' do
      let(:signup_email) { 'just@beingmiley.com' }

      it 'creates a user' do
        post api_v1_sign_up_path, params: signup_params

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['user']['name']).to eq(signup_params[:user][:name])
      end
    end
  end

  describe 'showing a logged in users information' do
    context 'when the user is not logged in' do
      it 'does not response with any user information' do
        get api_v1_users_me_path

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
      end
    end

    context 'when the user is logged in' do
      let(:user) { create(:user) }
      let(:token) { JWT.encode({ user_id: user.id }, ENV['APP_SECRET']) }
      let(:headers) { { 'Authorization': "Bearer #{token}" } }

      it 'returns the user\'s info' do
        get api_v1_users_me_path, headers: headers

        expect(response).to have_http_status(200)
      end
    end
  end
end
