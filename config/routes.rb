Rails.application.routes.draw do 
  
  resources (:users) do
    resources :projects
  end

  resources (:projects) do
    resources :tasks
  end

  resources :tasks

  ############################

  get '/signup', to: "users#new", as: "signup"
  post '/signup', to: "users#create"
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  get "/auth/facebook/callback", to: "sessions#create_with_fb"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
