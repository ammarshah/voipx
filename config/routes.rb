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
    get :unread_messages_count, on: :collection
  end
  resources :routes, only: [:create, :edit, :update, :destroy]
  
  # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  # conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get 'search', to: 'search#index'

  resources :contacts, only: [:index]
  resources :favorites, only: [:index, :create, :destroy]

  get 'pricing', to: 'visitors#pricing'

  resources :subscriptions do
    member do
      get :make_recurring
    end
  end

  post 'paypal/ipn_listener' => 'paypal#ipn_listener'
end
