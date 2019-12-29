Rails.application.routes.draw do
  root 'albums#index'
  resources :albums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
