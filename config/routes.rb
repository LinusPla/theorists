Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :theorists do
    resources :bookings
    resources :reviews, only: [:create, :edit, :update, :destroy]
    # I dont know how we want the routes here
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
