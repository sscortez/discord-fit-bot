# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  namespace :webhook_events do
    post 'interactions', action: :create, controller: 'interactions'
    get  'interactions', action: :index, controller: 'interactions'
  end
end
