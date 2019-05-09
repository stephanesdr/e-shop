# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'home/landing#index'

  namespace 'home' do
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
    resources :search, only: %i[index]
  end

  namespace 'administration' do
    get '/admin', to: 'items#index'
    get '/sending_room/', to: 'orders#sending_room'
    resources :orders, only: %i[index show update] do
      get '/postal_sticker/', to: 'orders#postal_sticker'
      get '/items_checklist/', to: 'orders#items_checklist'
    end
    resources :kpi, only: %i[index]
    resources :items, only: %i[index show update create new edit destroy]
    resources :users
  end
end
