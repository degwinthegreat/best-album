# frozen_string_literal: true

Rails.application.routes.draw do
  root 'albums#index'
  resources :albums
  resources :y2020, only: :index
end
