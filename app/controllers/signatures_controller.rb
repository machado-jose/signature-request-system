class SignaturesController < ApplicationController

  def index
    @signature = Signature.signature_valid(params[:signature_id])
    if @signature.blank?
      puts "[X] Error in signatures#index: #{exception}"
      render :error
    end
    @signature
  end

  def download_file
    begin
      download_file = Solicitation.find(params[:solicitation_id])

      send_file Rails.root.join('storage', download_file.document.path),
      :filename => download_file.document_file_name,
      :type => download_file.document_content_type,
      :disposition => 'attachment'

    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_path(params[:signature_id]), notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    end
  end

  def error
  end

  def submit
    # Creation Fase
    params_signatory = get_signature_params
    # Verification
    if params_signatory[:signature_image].empty? ^ params_signatory[:justification].empty?

    else
      render :error
    end

  end

  private
  def get_signature_params
    params.require(:signature).permit(:signature_image,
       :justification,
       :solicitation_id, 
       :signatory_id
      )
  end

  def verify_authenticity_link
    
  end
end
