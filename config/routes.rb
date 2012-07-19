DesignReview::Application.routes.draw do

  authenticated :user do
    root :to => 'talks#index'
  end
  
  root :to => "home#index"
  
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  
  resources :users, :only => [:show, :index]
  resources :talks
  resources :attendances, only: [:create, :destroy]

end
