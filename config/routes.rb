Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :employees, only: [:show]
  resources :merchants, only: [:show]
  resources :customers, only: [:show, :edit, :update, :index]
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

end
