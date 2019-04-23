# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'home/categories#index'

  get '/landing', to: 'landing#landing_page'

  resources :profiles
  resources :carts, only: %i[index]

  namespace 'home' do
    get '/', to: 'categories#index'
    resources :categories
  end
end
