Rails.application.routes.draw do

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index] do
    resources :comments, only: :new
  end
  resources :comments, only: [:create, :destroy]
end
