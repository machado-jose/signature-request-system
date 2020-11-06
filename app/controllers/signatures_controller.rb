class SignaturesController < ApplicationController

  def index
    @signatory = Signatory.find_by(id: params[:signatory_id])
    
    unless @signatory
      render :error
    end
    # New signature
    @signature = Signature.new
    @signature.signatory_id = @signatory.id

    begin
      @signature.solicitation_id = Solicitation.find(@signatory.id).id
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
      redirect_to signature_path(params[:signatory_id]), notice: 'Error while downloading. Send an email to the Call Center for any clarification'
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
end
