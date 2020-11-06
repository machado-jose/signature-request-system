Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update]
  get 'signature/:signatory_id', to: 'signatures#index', as: 'signature'
  get 'signature/download/:signatory_id/:solicitation_id', to: 'signatures#download_file', as: 'document_download_signature'
  post 'signature/submit', to: 'signatures#submit', as: 'signature_submit'
  root to: 'solicitations#index'
end
