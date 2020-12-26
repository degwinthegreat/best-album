# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'
  resources :albums, only: %i[index new create edit update destroy]
  resources :y2020, only: :index
end
