Todo::Application.routes.draw do
  namespace :Api do
    resources :lists
  end
  #namespace :Api do

    #resources :users do
      #resources :lists, except: [:index]
    #end

    #resources :lists, only: [] do
      #resources :items, only: [:create, :new]
    #end

    #resources :items, only: [:destroy]

  #end

  root to: 'users#new'
end
