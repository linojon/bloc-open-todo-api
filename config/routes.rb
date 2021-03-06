Todo::Application.routes.draw do

  namespace :api do
    resources :users, only: [:index, :create] do
      resources :lists, only: [:index, :create]
    end
  end

  resources :users do 
    resources :lists, except: [:index]
  end

  resources :lists, only: [] do
    resources :items, only: [:create, :new]
  end

  resources :items, only: [:destroy]

  root to: 'users#new'
end
