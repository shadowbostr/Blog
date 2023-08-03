# frozen_string_literal: true
Rails.application.routes.draw do


  # Sets home page to topics/index.html.erb
  root to: 'topics#index'

  resources :topics


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
