# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'home/categories#index'

  get '/landing', to: 'landing#landing_page'

  # resources :carts, only: %i[index destroy]
  # resources :cart_items, only: %i[update destroy]
  # resources :orders, only: %i[create]

  namespace 'home' do
    get '/', to: 'categories#index'

    resources :carts, only: %i[index destroy]
    resources :cart_items, only: %i[update destroy]
    resources :orders, only: %i[create new show]

    resources :categories do
      resources :items, only: %i[index destroy]
    end

    resources :profiles
    resources :items, only: %i[index show]
    resources :payments, only: %i[index]
  end

  namespace 'administration' do
    get '/admin', to: 'items#index'
    resources :orders, only: %i[index show update]
    resources :items, only: %i[index show update create new edit destroy]
    resources :users
  end
end
