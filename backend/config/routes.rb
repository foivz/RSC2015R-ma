Rails.application.routes.draw do

  # Api
  namespace :api, defaults: { format: :json } do
    namespace :authentication do
      post :login, :logout

      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
