# frozen_string_literal: true

Rails.application.routes.draw do
  scope :charts do
    get :consumer_indicies, to: "charts#consumer_indicies", as: :consumer_index_chart
  end

  resources :index_rent_calculators, only: [:index, :show, :create]

  resource :session, only: [:new, :create, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
  root "dashboard#index"
end
