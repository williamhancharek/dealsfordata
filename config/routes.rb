Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "home#index"

  resources :users, only: [:show]
  resources :admin, only: [:show]
  resources :employees, only: [:show]
  resources :merchants, only: [:show]
  resources :customers, only: [:show]
  resources :faq, only: [:index]

end
