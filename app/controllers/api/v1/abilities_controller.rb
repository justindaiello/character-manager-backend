module Api::V1
  class AbilitiesController < ApplicationController
    def index
      @abilities = Ability.all
      render json: @abilities
    end

    def create
      @ability = Ability.new(ability_params)

      if @ability.save
        render json: @ability, status: :created
      else
        render json: @ability.errors, status: :unprocessable_entity
      end
    end

    private

    def ability_params
      params.require(:ability).permit(
        :strength,
        :charisma, 
        :wisdom,
        :constitution,
        :intelligence,
        :dexterity
      )
    end
  end
end
