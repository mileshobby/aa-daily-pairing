Rails.application.routes.draw do
  root 'subs#index'

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: [:index]
end
