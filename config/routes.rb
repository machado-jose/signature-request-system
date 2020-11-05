Rails.application.routes.draw do
  resources :signatures, only: [:index]
  resources :solicitations, except: [:edit, :update]

  root to: 'solicitations#index'
end
