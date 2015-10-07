Rails.application.routes.draw do

  devise_for :users, :path => ''

  resources :projects, only: [:new, :create, :show] do
    member do
      get '/run_page_speed_test', to: 'page_speed_results#new'
      post '/run_page_speed_test', to: 'page_speed_results#create'
    end
  end

  root 'user_projects#index'
end