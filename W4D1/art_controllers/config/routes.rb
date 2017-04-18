Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users,  only: [:index, :show, :update, :destroy, :create] do
    resources :artworks, only: :index
    resources :comments, only: :index

  end

  resources :artworks,  only: [:show, :update, :destroy, :create] do
    resources :comments, only: :index
  end

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

end
