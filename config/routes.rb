Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/users', to: 'users#index'
      post '/users', to: 'users#create'

      get '/characters', to: 'characters#index'
      post '/characters', to: 'characters#create'
    end
  end
end
