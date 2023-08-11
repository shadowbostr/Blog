# frozen_string_literal: true

Rails.application.routes.draw do

  # Sets home page to topics/index.html.erb
  root to: 'topics#index'

  get '/posts', to: 'posts#index'

  concern :commentable do
    resources :comments
  end

  # Shallow routing used in below nested routes
  resources :topics, shallow: true do
    #Nestes routes for comment actions inside the routes of posts
    resources :posts, concerns: :commentable
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
