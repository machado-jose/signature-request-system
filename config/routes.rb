Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update, :delete]
  get 'solicitations/cancel/:id', to: 'solicitations#cancel', as: 'solicitation_cancel'

  get 'signatures/:filename', to: 'signatures#image'
  
  get 'signature/error', to: 'signatures#error', as: 'signature_error'
  get 'signature/success', to: 'signatures#success', as: 'signature_success'
  get 'signature/:signature_token', to: 'signatures#edit', as: 'signature'
  patch 'signature/submit', to: 'signatures#update', as: 'signature_submit'

  get 'download/document/:document_token', to: 'downloads#download_document', as: 'download_document'
  get 'download/signatures/:signature_token', to: 'downloads#download_signature', as: 'download_signature'
  
  root to: 'solicitations#index'
end
