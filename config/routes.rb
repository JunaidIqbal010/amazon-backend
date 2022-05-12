Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
      resources :orders, only: [:index]
      resources :checkout, only: [:create]
      post '/sync-cart', to: "carts#sync_cart"
      post '/login', to: "authentication#login"
      post '/sign-up', to: "authentication#sign_up"
      post '/order', to: "orders#create_order"
    end
  end
end
