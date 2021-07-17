require 'rails_helper'

RSpec.describe Api::V1::CharactersController do
  let(:character_params) do
    {
      character: {
        name: 'Camus Moongem',
        level: 10,
        race: 'gnome',
        character_class: character_class_type
      }
    }
  end

  describe 'GET #index' do
    let(:character_class_type) { 'wizard' }

    before do
      @character = Character.create(character_params[:character])
      get :index
    end

    it 'assigns @characters' do
      expect(assigns(:characters)).to eq([@character])
    end

    it 'responds with JSON' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)[0]['name']).to eq('Camus Moongem')
    end
  end

  describe 'POST #create' do
    context 'when there is an invalid parameter' do
      let(:character_class_type) { 'Sloth' }

      it 'does not allow creation of an invalid character class' do
        post :create, params: character_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['character_class']).to include('Invalid class type')
      end
    end

    context 'when there are valid parameters' do
      let(:character_class_type) { 'wizard' }

      it 'returns creates and returns the character' do
        post :create, params: character_params

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['character_class']).to eq('wizard')
      end
    end
  end
end
