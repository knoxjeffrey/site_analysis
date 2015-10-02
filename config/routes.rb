Rails.application.routes.draw do

  devise_for :users, :path => ''

  resources :projects, only: [:new, :create]

  root 'projects#index'
end
