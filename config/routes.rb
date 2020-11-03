Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update]

  root to: 'solicitations#index'
end
