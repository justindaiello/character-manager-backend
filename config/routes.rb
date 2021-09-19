Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/users', to: 'users#index'
      get '/users/me', to: 'users#show'
      post '/sign-up', to: 'users#create'

      post '/login', to: 'authentications#create'

      get '/characters', to: 'characters#index'
      get 'characters/:id', to: 'characters#show'
      post '/characters', to: 'characters#create'
      patch '/characters/:id', to: 'characters#update'
      delete '/characters/:id', to: 'characters#destroy'
    end
  end
end
