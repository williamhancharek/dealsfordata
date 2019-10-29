Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :employees, only: [:show]
  resources :merchants, only: [:show]
  resources :customers, only: [:show, :edit, :update]
  resources :faq, only: [:index]
  resources :offers, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  namespace :plaid do
    resources :access_token, only: [:create]
  end

  namespace :webhooks do
    resources :plaid_webhook, only: [:index]
  end

  namespace :admin do
    resources :users
  end

  namespace :customers do
    resources :offers
  end

  namespace :merchants do
    resources :offers, only: [:index, :show]
  end

  namespace :employees do
    resources :customers, only: [:index, :show]
    resources :merchants
  end

end
