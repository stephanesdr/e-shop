# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'home/landing#index'

  namespace 'home' do
    get '/', to: 'categories#index'

    resources :carts, only: %i[index destroy]
    resources :cart_items, only: %i[update destroy]
    resources :orders, only: %i[create new show] do
      get '/invoice/', to: 'orders#invoice'
    end

    resources :categories do
      resources :items, only: %i[index destroy]
    end

    resources :profiles
    resources :items, only: %i[index show] do
      resources :cart_items, only: %i[create]
    end
    resources :payments, only: %i[index]
  end

  namespace 'administration' do
    get '/admin', to: 'items#index'
    resources :orders, only: %i[index show update] do
      get '/postal_sticker/', to: 'orders#postal_sticker'
    end
    resources :items, only: %i[index show update create new edit destroy]
    resources :users
  end
end
