Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  namespace :api, default: { format: :json } do
    namespace :v1 do
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
