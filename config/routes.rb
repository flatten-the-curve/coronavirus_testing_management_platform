Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root "home#index"
  resources :hosts
  resources :patient_counts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
