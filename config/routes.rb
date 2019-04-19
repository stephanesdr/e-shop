# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home/categories#index'

  get '/landing', to: 'landing#landing_page'

  namespace 'home' do
    get '/', to: 'categories#index'
    resources :categories
  end
end
