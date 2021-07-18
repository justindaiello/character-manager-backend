module Api::V1
  class UsersController < ApplicationController
    before_action :require_login, only: %i[index show]

    def index
      @users = User.all
      render json: @users
    end

    def create
      @user = User.create(user_params)

      if @user.save
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: :created
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def show
      render json: @user, except: [:password_digest]
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
