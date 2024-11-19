# frozen_string_literal: true

Rails.application.routes.draw do
  # Internal
  resource :session, only: [:new, :create, :destroy]
  resource :navigation, only: [:show]

  # App
  scope :charts do
    get :consumer_indicies, to: "charts#consumer_indicies", as: :consumer_index_chart
  end
  resource :calculator, only: [:show, :create]
  resources :consumer_indicies, only: [:index, :show]

  resources :collections

  get "up" => "rails/health#show", as: :rails_health_check
  root "dashboard#index"
end
