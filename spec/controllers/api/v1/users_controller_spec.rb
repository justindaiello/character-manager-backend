require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'GET #index' do
    before do
      @user = User.create(name: 'Luke Skywalker')
      get :index
    end

    it 'assigns @users' do
      expect(assigns(:users)).to eq([@user])
    end

    it 'returns a 200 on success' do
      expect(response).to have_http_status(200)
    end

    it 'responds with JSON' do
      expect(JSON.parse(response.body)).to include(hash_including('name' => 'Luke Skywalker'))
    end
  end
end
