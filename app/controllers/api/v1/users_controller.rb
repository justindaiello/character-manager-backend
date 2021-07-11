module Api::V1
  class UsersController < ApplicationController
    def index
      @users = User.all
      render json: @users
    end

    def create
      @user = User.new(user_params)

      if @jobs.save
        render json: @users, status: created
      else
        render json: @users.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.requre(:user).permit(:name, :email)
    end
  end
end
