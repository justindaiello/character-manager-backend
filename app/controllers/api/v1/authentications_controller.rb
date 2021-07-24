module Api::V1
  class AuthenticationsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])

      if user && user&.authenticate(params[:password])
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }, except: [:password_digest], status: :created
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    end
  end
end
