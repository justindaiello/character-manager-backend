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
  let(:character) { create(:character, ability: ability) }
  let(:ability) { create(:ability) }

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

  describe 'showing a single character' do
    context 'when there is no valid character' do
      it 'throws a 401' do
        get '/api/v1/characters/123456'

        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)['error']).to eq('Character with id: 123456 does not exist')
      end
    end

    context 'when the character exists' do
      it 'reponds with the character info' do
        get "/api/v1/characters/#{character.id}"

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['ability']).not_to be_nil
      end
    end
  end

  describe 'creating a character' do
    context 'when there is no token or an invalid token' do
      let(:character_class_type) { 'wizard' }

      it 'throws a 401' do
        post api_v1_characters_path, params: character_params

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
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
          expect(JSON.parse(response.body)['ability']).to be_nil
          expect(JSON.parse(response.body)['character_class']).to eq('wizard')
        end
      end

      context 'when there are nested attributes' do
        let(:nested_character_params) do
          {
            character: {
              name: 'Camus Moongem',
              level: 10,
              race: 'gnome',
              character_class: 'warlock',
              ability_attributes: {
                strength: rand(1..18),
                dexterity: rand(1..18),
                constitution: rand(1..18),
                intelligence: rand(1..18),
                wisdom: rand(1..18),
                charisma: rand(1..18)
              }
            }
          }
        end

        it 'creates a character with abilities' do
          post api_v1_characters_path, params: nested_character_params, headers: headers

          expect(response).to have_http_status(201)
          expect(JSON.parse(response.body)['ability']).not_to be_nil
        end
      end
    end
  end

  describe 'updating a character' do
    let(:new_character) { create(:character) }
    let(:new_character_params) { { id: new_character.id, name: 'Burt Reynolds' } }

    context 'when there is no token or an invalid token' do
      it 'throws a 401' do
        patch "/api/v1/characters/#{new_character.id}", params: { character: new_character_params }

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
      end
    end

    context 'when the params are valid' do
      it 'updates the character' do
        patch "/api/v1/characters/#{new_character.id}", params: {
          character: new_character_params
        }, headers: headers

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['name']).to eq(new_character_params[:name])
      end
    end
  end

  describe 'deleting a character' do
    context 'when there is an invalid token' do
      it 'throws a 401' do
        delete "/api/v1/characters/#{character.id}"

        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
      end
    end

    context 'when there is a valid token' do
      it 'deletes the character' do
        delete "/api/v1/characters/#{character.id}", headers: headers

        expect(response).to have_http_status(200)
        expect(response.body).to eq("#{character.name} has been deleted.")
      end
    end
  end
end
