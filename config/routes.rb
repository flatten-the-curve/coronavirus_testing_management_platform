Rails.application.routes.draw do
  constraints(host: /^www\./i) do
    match "(*any)", via: :all, to: redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, "") }.to_s
    }
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  get "home/index"
  resources :hosts
  resources :address_search, only: [:index]
  resources :patient_counts
  resources :line_counts

  root "home#index"
end
