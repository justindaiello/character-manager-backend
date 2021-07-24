require 'rails_helper'

RSpec.describe Api::V1::CharactersController, type: :request do
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
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, ENV['APP_SECRET']) }
  let(:headers) { { 'Authorization': "Bearer #{token}" } }

  describe 'fetching all characters' do
    let(:character_class_type) { 'wizard' }

    before do
      @character = Character.create(character_params[:character])
      get api_v1_characters_path
    end

    it 'assigns @characters' do
      expect(assigns(:characters)).to eq([@character])
    end

    it 'returns characters' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)[0]['name']).to eq('Camus Moongem')
    end
  end

  describe 'creating a character' do
    context 'when there is no token or an invalid token' do
      let(:character_class_type) { 'wizard' }

      it 'throws a 401' do
        post api_v1_characters_path, params: character_params

        expect(response).to have_http_status(401)
      end
    end

    context 'when there is a valid token' do
      context 'when there is an invalid parameter' do
        let(:character_class_type) { 'Sloth' }

        it 'does not allow creation of an invalid character class' do
          post api_v1_characters_path, params: character_params, headers: headers

          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['character_class']).to include('Invalid class type')
        end
      end

      context 'when there are valid parameters' do
        let(:character_class_type) { 'wizard' }

        it 'returns creates and returns the character' do
          post api_v1_characters_path, params: character_params, headers: headers

          expect(response).to have_http_status(201)
          expect(JSON.parse(response.body)['character_class']).to eq('wizard')
        end
      end
    end
  end

  describe 'updating a character' do
    let(:new_character) { create(:character) }
    let(:character_params) do
      {
        character: {
          name: 'Camus Moongem',
          level: 10,
          race: 'gnome',
          character_class: 'hi'
        }
      }
    end

    context 'when there is no token or an invalid token' do
      it 'throws a 401' do
        new_character.character_class = 'warlock'
        patch "/api/v1/characters/#{new_character.id}", params: { character: new_character }

        expect(response).to have_http_status(401)
      end
    end

    context 'when the params are valid' do
      it 'updates the character' do
        patch "/api/v1/characters/#{new_character.id}", params: {
          character: { id: new_character.id, name: 'Burt Reynolds' }
        }, headers: headers

        expect(response).to have_http_status(200)
      end
    end
  end
end
