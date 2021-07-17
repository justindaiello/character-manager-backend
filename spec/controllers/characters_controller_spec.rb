require 'rails_helper'

RSpec.describe Api::V1::CharactersController do
  describe 'GET #index' do
    before do
      @character = Character.create(name: 'Ryu Nightbreeze')
      get :index
    end

    it 'assigns @characters' do
      expect(assigns(:characters)).to eq([@character])
    end

    it 'returns a 200 on success' do
      expect(response).to have_http_status(200)
    end

    it 'responds with JSON' do
      expect(JSON.parse(response.body)).to include(hash_including('name' => 'Ryu Nightbreeze'))
    end
  end
end
