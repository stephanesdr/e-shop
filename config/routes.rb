# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'home/categories#index'

  get '/landing', to: 'landing#landing_page'

  resources :profiles

  namespace 'home' do
    get '/', to: 'categories#index'
    resources :categories
  end

  namespace 'administration' do
    get '/admin', to: 'items#index'

    resources :items
  end
end
