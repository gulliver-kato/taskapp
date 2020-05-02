# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit]
end
