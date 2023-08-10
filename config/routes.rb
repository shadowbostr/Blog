# frozen_string_literal: true
Rails.application.routes.draw do

  resources :posts
  # Sets home page to topics/index.html.erb
  root to: 'topics#index'

  #Shallow routing used in below nested routes
  resources :topics do
    resources :posts, only: [:index, :new, :create]
  end

  resources :posts, only: [:show, :destroy, :edit, :update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
