Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update]
  get 'signature/:signatory_id', to: 'signatures#index', as: 'signature'
  get 'signature/download/:solicitation_id', to: 'signatures#download_file', as: 'document_download_signature'
  root to: 'solicitations#index'
end
