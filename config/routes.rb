# frozen_string_literal: true

Rails.application.routes.draw do

  post 'reservations/create', to: 'reservations#create'
  post '/aeroplanes/create', to: 'aeroplanes#create'

  get '/current_user', to: 'current_user#index'

  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

resources :aeroplanes, only: [:destroy, :index, :show] do
  resources :reservations, only: [:destroy, :index, :show, :create] do
  end
end
end
