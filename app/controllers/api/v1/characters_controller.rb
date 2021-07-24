module Api::V1
  class CharactersController < ApplicationController
    before_action :require_login, only: %i[create update]

    def index
      @characters = Character.all
      render json: @characters
    end

    def create
      @character = Character.new(character_params)

      if @character.save
        render json: @character, status: :created
      else
        render json: @character.errors, status: :unprocessable_entity
      end
    end

    def update
      @character = Character.find(params[:id])

      if @character.update(character_params)
        render json: @character, status: :ok
      else
        render json: @character.errors, status: :unprocessable_entity
      end
    end

    private

    def character_params
      params.require(:character).permit(:name, :level, :character_class, :race)
    end
  end
end
