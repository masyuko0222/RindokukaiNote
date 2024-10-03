Rails.application.routes.draw do
  root to: "home#index" # tmp path

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: redirect('/login')

  resources :reading_clubs, only: [:index] do
    resources :participants, only: [:create, :destroy], controller: 'participants'
  end
end
