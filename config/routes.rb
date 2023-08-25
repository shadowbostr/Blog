# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  # Sets home page to topics/index.html.erb
  root to: 'topics#index'

  get '/posts', to: 'posts#index'
  get '/tags', to: 'tags#index'

  concern :commentable do
    resources :comments
  end

  concern :taggable do
    resources :tags
  end

  concern :ratable do
    resources :ratings, only: [:create]
  end


  # Shallow routing used in below nested routes
  resources :topics, shallow: true do
    # Nested routes for comment actions inside the routes of posts
    resources :posts, concerns: %i[ commentable taggable ratable ]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
