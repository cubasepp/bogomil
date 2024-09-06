# frozen_string_literal: true

Rails.application.routes.draw do
  resources :spread_sheets

  resource :session, only: [:new, :create, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
  root "dashboard#index"
end
