Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :companies, only: [:index, :show, :edit, :update] do
    resources :reports, only: [:destroy]
  end
  resources :users,     only: [:show, :edit, :update]
  resources :breakouts, only: [:index, :update]
  get 'dashboard', to: 'dashboard#index'
  resources :dashboard, only: [] do
    get :autocomplete_breakout_code, on: :collection
    get :autocomplete_breakout_destination, on: :collection
    post :match_route, on: :collection
  end
  resources :routes, only: [:new, :create]
  
end
