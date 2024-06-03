Rails.application.routes.draw do

  devise_for :users, 
    controllers: { registrations: 'registrations' } 
  
  root "posts#index"

  #resources :likes, only: [:create,:destroy]
  resources :users, only: [:show]
  resources :posts, only: [:new,:create,:index,:show,:destroy] do
    resources :likes, only: [:create,:destroy]
    member do
      get 'photos'
    end
  end

end
