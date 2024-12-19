# frozen_string_literal: true

Rails.application.routes.draw do
  # Internal
  resource :session, only: [:new, :create, :destroy]

  # App
  scope :charts do
    get :consumer_indicies, to: "charts#consumer_indicies", as: :consumer_index_chart
  end
  resource :calculator, only: [:show, :create]
  resources :consumer_indicies, only: [:show]

  resources :collections, only: [:index, :new, :update]
  resources :real_estates

  get "up" => "rails/health#show", as: :rails_health_check
  root "real_estates#index"
end
