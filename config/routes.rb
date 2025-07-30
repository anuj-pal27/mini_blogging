Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
    get 'dashboard', to: 'posts#dashboard', as: :dashboard
  end

  devise_scope :user do
    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :posts, param: :slug do
    resources :comments, only: [:create], param: :id
  end

  namespace :api, defaults: { format: :json } do
    resources :posts, only: [:index, :show], param: :slug
  end

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    get 'dashboard', to: 'dashboard#index'
    resources :posts, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
