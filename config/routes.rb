Rails.application.routes.draw do
  get 'render/index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
