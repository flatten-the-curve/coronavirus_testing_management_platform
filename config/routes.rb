Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "home/index"
  devise_for :users
  root "home#index"
  resources :home do
    collection do
      post :verify_questionnaire_recaptcha
    end
  end
  resources :hosts
  resources :address_search, only: [:index]
  resources :patient_counts
  resources :line_counts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
