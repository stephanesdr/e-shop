# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home/items#index'

  namespace 'home' do
    get '/', to: 'items#index'
    resources :items
  end
end
