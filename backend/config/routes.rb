Rails.application.routes.draw do

  # Api
  namespace :api, defaults: { format: :json } do
    namespace :authentication do
      post :login, :logout
    end

    resources :users, only: [:index, :show, :create, :update, :destroy] do
      get :me, on: :collection
      post :ready, path: 'ready', on: :member
      post :kill, path: 'kill', on: :member
      post :update_location, path: 'location', on: :member
    end

    resources :fields, only: [:index, :show, :create, :update, :destroy]

    resources :games, only: [:index, :show, :create, :update, :destroy] do
      post :join, path: 'join', on: :collection
      post :ready, path: 'ready', on: :member
      post :start, path: 'start', on: :member
    end

    resources :individual_messages, only: [:index, :inbox, :create] do
      get :inbox, path: 'inbox', on: :collection
    end

    resources :team_messages, only: [:index, :inbox, :create] do
      get :inbox, path: 'inbox', on: :collection
      post :attack, path: 'attack', on: :collection
      post :fallback, path: 'fallback', on: :collection
      post :cover, path: 'cover', on: :collection
    end
  end
end
