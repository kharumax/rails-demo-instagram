Rails.application.routes.draw do
  devise_for :users,
             controller: {registrations: "registrations"}

  root "posts#index"

  resources :users,only: [:show,:index]

  resources :posts,only: [:new,:create,:index,:show,:destroy] do
    resources :photos,only: [:create]

    resources :likes,only: [:create,:destroy]
    resources :comments,only: [:create,:destroy]
  end

  resources :relationships,only: [:create,:destroy]

end
