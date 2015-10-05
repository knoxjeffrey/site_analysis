Rails.application.routes.draw do

  devise_for :users, :path => ''

  resources :projects, only: [:new, :create, :show]

  root 'user_projects#index'
end
