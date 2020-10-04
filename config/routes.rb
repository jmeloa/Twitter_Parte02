Rails.application.routes.draw do
  get 'search/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :friends
  resources :likes
  resources :tweets   
  devise_for :users, controllers:{registrations: 'registrations'}
  get 'search' => 'search#index'
  root 'home#index'  
  resources :tweets do
    resources :likes
  end

  

    #devise_scope :user do
    #  get "/home_privados/index" => "home_privados_controller"
    #end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end