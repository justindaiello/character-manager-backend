module Api::V1
  class AbilitiesController < ApplicationController
    def index
      @abilities = Ability.all
      render json: @abilities
    end
  end
end
