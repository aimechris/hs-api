Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Advertiser
  post 'advertiser/signup', to: 'advertisers#create'
  post 'advertiser/auth/login', to: 'advertiserauthentication#authenticate'
  get 'advertiser/dashboard', to: 'advertisers#dashboard'
  ########################
  # Author
  post 'author/signup', to: 'authors#create'
  post 'author/auth/login', to: 'authorauthentication#authenticate'
  get 'author/dashboard', to: 'authors#dashboard'
  ########################
  # User
  post 'user/signup', to: 'users#create'
  post 'user/auth/login', to: 'userauthentication#authenticate'

  get 'search', to: 'listings#search'
  get 'filter', to: 'listings#filter'

  resources :listings do
    resources :listimages
  end
  resources :features
  resources :inquiries

  resources :posts do
    resources :tags
  end  
  resources :categories
end
