Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  namespace :api do
    namespace :v1 do
      resources :schools do
        resources :recipients
        resources :orders
      end
    end
  end
end
