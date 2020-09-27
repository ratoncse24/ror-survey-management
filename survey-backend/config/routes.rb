Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :surveys, only: [:index, :show] do
        resources :answers, only: [:index, :create]
      end
    end
  end
end

