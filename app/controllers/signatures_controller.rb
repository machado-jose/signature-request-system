class SignaturesController < ApplicationController

  def index
    @signature = signature_valid(params[:signature_id])
    if @signature.blank?
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

  def success
  end

  def submit
    # Creation Fase
    params_signature = get_signature_params
    # Verification
    if params_signature[:signature_image].empty? ^ params_signature[:justification].empty?
      # Checks if the datas weren't manipulated
      @signature = check_datas(params_signature[:id], params_signature[:solicitation_id])
      if @signature.blank?
        render :error
      end
      unless params_signature[:signature_image].empty?
        signature_image = Paperclip.io_adapters.for(params_signature[:signature_image])
        signature_image.original_filename = "signature_img_solicitation_#{params_signature[:solicitation_id]}_signature_#{params_signature[:id]}.png"
        @signature.update!(
          :is_signed => true,
          :signature_image => signature_image
        )
        redirect_to signature_success_path
      end
    else
      render :error
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

  def signature_valid(signature_id)
    Signature.where(:id => signature_id, :is_signed => false, :denied => false)[0]
  end

  def check_datas(signature_id, solicitation_id)
    Signature.where(:id => signature_id, :solicitation_id => solicitation_id)[0]
  end
end
