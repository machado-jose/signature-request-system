Rails.application.routes.draw do
  resources :solicitations, except: [:edit, :update]
  get 'signatures/:filename', to: 'signatures#image'
  get 'signature/error', to: 'signatures#error', as: 'signature_error'
  get 'signature/success', to: 'signatures#success', as: 'signature_success'
  get 'signature/:signature_token', to: 'signatures#index', as: 'signature'
  get 'signature/download/:solicitation_id', to: 'signatures#download_document', as: 'document_download_signature'
  get 'signature/success/download', to: 'signatures#download_signature_image', as: 'signature_image_download'
  patch 'signature/submit', to: 'signatures#submit', as: 'signature_submit'
  root to: 'solicitations#index'
end
