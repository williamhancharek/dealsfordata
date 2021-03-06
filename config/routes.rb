Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'

  authenticate :user, lambda {|u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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
  end

  scope module: 'admin' do
    resources :admin, only: [:show]
  end

  scope module: 'customers', as: 'customer', path: 'customers' do
    #resources :home, only: [:show] #DEPECRATED
    resources :offers, only: [:edit, :update, :show, :create, :destroy]
    resources :completed_offers, only: [:update, :destroy, :show]
    resources :subscriptions, only: [:create, :edit, :update, :show, :destroy]
    resources :users, only: [:show, :edit, :update]
    resources :foreign_boxes, only: [:show]

    resources :boxes, only: [:show, :edit, :update, :destroy, :index, :create] do
      resources :foreign_boxes, only: [:index]
      resources :foreign_subscriptions, only: [:index]
      resources :foreign_completed_offers, only: [:index]
      resources :offers, only: [:index, :new]
      resources :completed_offers, only: [:index]
      resources :subscriptions, only: [:index]
      resources :subscribers, only: [:index] #TODO map out
    end
  end

  scope module: 'merchants', as: 'merchant', path: 'merchants' do
    resources :home, only: [:show]
    resources :users, only: [:show, :edit, :update] do
      resources :offers, only: [:index]
    end
    resources :offers, only: [:show]
  end

  scope module: 'employees', path: 'employees', as: 'employee' do
    resources :merchants, only: [:index]
    resources :customers, only: [:index]
    resources :offers, only: [:show, :edit, :update, :destroy, :new, :create]
    resources :iframes, only: [:new, :create]

    resources :users, only: [:new, :create, :show] do
      resources :campaigns, only: [:index, :new, :create]
    end

    resources :boxes, only: [:show, :edit, :update, :destroy, :index] do
      resources :offers, only: [:index]
    end

    resources :campaigns, only: [:show, :edit, :update, :destroy] do
      resources :offers, only: [:index]
    end
  end
  resources :employees, only: [:show]

  scope module: 'moderators', path: 'moderators', as: 'moderator' do
    resources :home, only: [:show]
    resources :employees, only: [:index, :edit, :update]
    resources :offers, only: [:update, :destroy, :show]
    resources :assignments, only: [:create, :destroy]

    resources :boxes, only: [:show, :index] do
      resources :offers, only: [:index]
    end
  end

  resources :moderators, only: [:show]

  resources :faq, only: [:index]

end
