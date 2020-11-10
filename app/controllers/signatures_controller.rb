class SignaturesController < ApplicationController

  def edit
    respost = AppServices::SignatureTokenValidation.new(params[:signature_token]).call
    if respost.success?
      @signature = respost.signature
      @signature
    else
      redirect_to signature_error_path, notice: respost.error
    end
  end

  def update
    params_signature = get_signature_params
    respost = SignatureServices::UpdateSignature.new(params_signature).call
    if respost.success?
      if respost.status == 'accept'
        redirect_to signature_success_path(
          signature_token: respost.signature.signature_token
        )
      else
        redirect_to signature_success_path
      end
    else
      redirect_to signature_error_path, notice: respost.error.split(': ')[1] + ' Contact the Call Center.'
    end
  end

  def error
  end

  def success
    unless params[:signature_token].blank?
      @signature = Signature.find_by(:signature_token => params[:signature_token])
      if @signature.blank? 
        redirect_to signature_error_path 
      else 
        @signature
      end
    end
  end

  private

  def get_signature_params
    params.require(:signature).permit(
       :signature_image,
       :justification,
       :solicitation_id, 
       :id
      )
  end
end
