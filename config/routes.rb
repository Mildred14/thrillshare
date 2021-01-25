Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions passwords]

  namespace :api, default: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post '/signup', to: 'registrations#create'
        post '/login', to: 'sessions#create'
        delete '/logout', to: 'sessions#destroy'
      end
      resources :schools do
        resources :recipients
        resources :orders, except: :destroy

        post "/orders/:id/ship" => "order_shipments#create"
        post "/orders/:id/receive" => "order_receivements#create"
        post "/orders/:id/cancel" => "order_cancels#create"
      end
    end
  end
end
