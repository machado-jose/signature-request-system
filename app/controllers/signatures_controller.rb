class SignaturesController < ApplicationController

  def index
    begin
      @signature = Signature.find(params[:signature_id])
    rescue ActiveRecord::RecordNotFound => exception
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
      @signature = Signature.new
      unless params_signatory[:signature_image].empty?

      else
        # Signature Denied
        @signature.denied = true
        @signature.justification = params_signatory[:justification]
        puts ">>>>>>>>>>>>>>> #{@signature}"

        ## Needs to test if signatory and solicitation are valide
      end

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

  def verify_solicitation_authenticity(signatory_id, solicitation_id)
    begin
      signatory = Signatory.find_by(id: signatory_id)
      solicitation = Solicitation.find_by(id: solicitation_id)
      unless signatory[:solicitation_id] == solicitation_id
        ## throw exception
      end
      true
    rescue => exception
      
    end
  end
end
