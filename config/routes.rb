Rails.application.routes.draw do
  resources :users , only: [:new,:create]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  get 'sessions/login', to: 'sessions#new', as: :login
  post 'sessions/login', to:  'sessions#create', as: nil
  delete 'sessions/logout' , to: 'sessions#destroy', as: :logout
  get 'home/index'
  get '/', to: 'home#index', as: :homepage
  resources :products
  post 'products/search/search', to: 'products#search', as: :search
  post 'products/:id/bid', to: 'products#bid', as: :bid
  get 'products/:id/buynow', to: 'products#buynow', as: :buynow
  get 'products/:id/like', to: 'products#like', as: :like
  get 'products/:id/dislike', to: 'products#dislike', as: :dislike
  get 'products/:id/end', to: 'products#end', as: :end
  get 'products/:id/accept', to: 'products#accept', as: :accept
  post 'products/:id/decline', to: 'products#decline', as: :decline
  get 'products/search/search', to: 'products#index'

  get 'users/:id/block', to: 'users#block', as: :block
  get 'users/:id/unblock', to: 'users#unblock', as: :unblock

  get 'staffs', to: 'staffs#show', as: :staff
  get 'admins', to: 'admins#show', as: :admin
  post 'admins/createuser', to: 'admins#create_user', as: :create_user
  #get 'users/:id/delete', to: 'admins#delete_user', as: :delete_user

  get 'user/info/:id', to: 'user_info#show', as: :profile
  get 'user/info/edit/:id', to: 'user_info#show_edit', as: :edit_profile
  post 'user/info/edit/:id', to: 'user_info#edit', as: nil

  get 'checkout/product/:id', to: 'checkout#show', as: :checkout
  post 'checkout', to: 'checkout#checkout', as: nil

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
