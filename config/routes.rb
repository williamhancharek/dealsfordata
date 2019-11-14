Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "home#index"
  namespace :plaid do
    resources :access_token, only: [:create]
  end

  namespace :webhooks do
    resources :plaid_webhook, only: [:index]
  end

  scope module: 'admin', path: 'admin', as: 'admin' do
    resources :users
    resources :home, only: [:show]
  end

  scope module: 'admin' do
    resources :admin, only: [:show]
  end

  scope module: 'customer', as: 'customer', path: 'customer' do
    resources :home, only: [:show]
    resources :offers, only: [:edit, :update, :show]

    resources :users, only: [:show, :edit, :update] do
      resources :boxes, only: [:index, :new, :create]
    end

    resources :boxes, only: [:show, :edit, :update, :destroy] do
      resources :offers, only: [:index]
      resources :completed_offers, only: [:index]
    end
  end

  scope module: 'merchants', as: 'merchants', path: 'merchants' do
    resources :users, only: [:show, :edit, :update] do
      resources :offers, only: [:index]
    end
    resources :offers, only: [:show]
  end

  scope module: 'employees', path: 'employees', as: 'employee' do
    resources :home, only: [:show]

    scope module: 'users' do
      resources :users, only: [:new, :create, :show] do
        resources :campaigns, only: [:index, :new, :create]
        resources :boxes, only: [:index]
      end
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
    end

    scope module: 'boxes' do
      resources :boxes, only: [:show, :edit, :update, :destroy, :index] do
        resources :offers, only: [:index]
      end
    end
    scope module: 'offers' do
      resources :offers
    end
  end

  resources :employees, only: [:show]
  resources :faq, only: [:index]
end
