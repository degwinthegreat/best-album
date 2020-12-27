# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'
  resources :albums, only: %i[index new create edit update destroy]
  resources :y2019, only: :index
  resources :y2020, only: :index
end
