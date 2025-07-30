Rails.application.routes.draw do
  resources :posts
  devise_for :users

  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'dashboard', to: 'dashboard#index'
end
