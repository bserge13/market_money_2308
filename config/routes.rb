Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do 
    namespace :v0 do 
      resources :vendors, only: [:show, :create, :update, :destroy] 
      
      resources :markets, only: [:index, :show] do 
        resources :vendors, only: [:index], controller: "market_vendors" 
      end 

      resources :market_vendors
    end 
  end
end
