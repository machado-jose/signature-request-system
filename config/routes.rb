Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update]
  get 'signature/success', to: 'signatures#success', as: 'signature_success'
  get 'signature/:signature_id', to: 'signatures#index', as: 'signature'
  get 'signature/download/:signatory_id/:solicitation_id', to: 'signatures#download_file', as: 'document_download_signature'
  patch 'signature/submit', to: 'signatures#submit', as: 'signature_submit'
  root to: 'solicitations#index'
end
