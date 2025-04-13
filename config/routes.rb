Rails.application.routes.draw do
  devise_for :personnes, controllers: { registrations: 'personnes/registrations' }

  root to: 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check

  resources :personnes
  resources :participants
  resources :administrateurs
  resources :tontines do
    resources :participations, only: [:new, :create, :destroy]
    resources :tours do
      member do
        post 'tirer_beneficiaire'
      end
      resources :contributions, only: [:new, :create, :edit, :update]
    end
    resources :participants, only: [:new, :create, :destroy]
  end
  resources :tours
  resources :notifications
end