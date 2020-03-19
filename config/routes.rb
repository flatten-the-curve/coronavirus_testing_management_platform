Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  get 'home/index'
  devise_for :users
  root "home#index"
  resources :hosts
  resources :patient_counts
  resources :line_counts
  resources :questionnaire
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
