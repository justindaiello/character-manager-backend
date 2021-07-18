Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/users', to: 'users#index'
      get '/users/me', to: 'users#show'
      post '/sign-up', to: 'users#create'

      post '/login', to: 'authentications#create'

      get '/characters', to: 'characters#index'
      post '/characters', to: 'characters#create'
    end
  end
end
