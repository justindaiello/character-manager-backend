module Api::V1
  class CharactersController < ApplicationController
    before_action :require_login, only: %i[create update destroy]

    def index
      @characters = Character.all
      render json: @characters, include: :ability
    end

    def create
      @character = @user.characters.new(character_params)

      if @character.save
        render json: @character, include: :ability, status: :created
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

    def show
      @character = Character.includes(:ability).find(params[:id])

      render json: @character, include: :ability
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Character with id: #{params[:id]} does not exist" }, status: :not_found
    end

    def destroy
      @character = Character.find(params[:id])
      @character.destroy

      render json: "#{@character.name} has been deleted.", status: :ok
    end

    private

    def character_params
      params.require(:character)
            .permit(
              :name, :level, :character_class, :race,
              ability_attributes: %i[
                strength
                charisma
                wisdom
                constitution
                intelligence
                dexterity
              ]
            )
    end
  end
end
