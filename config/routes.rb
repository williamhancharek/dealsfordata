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
  end

  scope module: 'admin' do
    resources :admin, only: [:show]
  end
  #
  # namespace 'admin' do
  #   resources :users
  # end

  scope module: 'customers' do
    resources :customers, only: [:show, :edit, :update] do
      resources :offers, only: [:index, :show, :edit, :update]
      scope module: 'offers' do
        resources :completed, only: [:index]
      end
    end
  end

  scope module: 'merchants' do
    resources :merchants, only: [:show, :edit, :update] do
      resources :offers, only: [:index, :show]
    end
  end

  scope module: 'employees/customers', path: 'employees', as: 'employee' do
    resources :customers, only: [:show, :edit, :update, :index] do
        resources :offers, only: [:index]
    end
  end

  scope module: 'employees/merchants', path: 'employees', as: 'employee' do
    resources :merchants, only: [:show, :edit, :update, :index, :new, :create, :destroy] do
        resources :offers, only: [:index]
    end
  end

  scope module: 'employees', path: 'employees', as: 'employee' do
    resources :offers, only: [:show, :edit, :update, :new, :create, :destroy]
  end



  resources :employees, only: [:show]
  resources :faq, only: [:index]
  resources :offers, only: [:index, :show, :edit, :update]

end
