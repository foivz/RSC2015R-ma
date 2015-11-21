Rails.application.routes.draw do

  # Api
  namespace :api, defaults: { format: :json } do
    namespace :authentication do
      post :login, :logout
    end

    resources :users, only: [:index, :show, :create, :update, :destroy] do
      get :me, on: :collection
      put :update_location, path: 'location', on: :member
    end

    resources :fields, only: [:index, :show, :create, :update, :destroy]

    resources :games, only: [:index, :show, :create, :update, :destroy] do
      post :join, path: 'join', on: :collection
      put :start, path: 'start', on: :member
    end

    resources :individual_messages, only: [:index, :inbox, :create] do
      get :inbox, path: 'inbox', on: :collection
    end

    resources :team_messages, only: [:index, :inbox, :create] do
      get :inbox, path: 'inbox', on: :collection
    end
  end
end
