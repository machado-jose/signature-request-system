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
          solicitation_id: params_signature[:solicitation_id],
          signature_image_filename: respost.signature.signature_image_file_name
        )
      else
        redirect_to signature_success_path
      end
    else
      redirect_to signature_error_path, notice: respost.error.split(': ')[1] + ' Contact the Call Center.'
    end
  end

  def download_document
    begin
      download_document = Solicitation.find(params[:solicitation_id])
      download_file(
        download_document.document.path,
        download_document.document_file_name,
        download_document.document_content_type
      )
    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      if params[:signature_image_filename].blank?
        puts "[X] Error in signatures#download_file: #{exception}"
        redirect_to signature_path(params[:solicitation_id]), notice: 'Error while downloading. Send an email to the Call Center for any clarification'
      else
        puts "[X] Error in signatures#download_file: #{exception}"
        redirect_to signature_success_path(
        solicitation_id: params[:solicitation_id],
        signature_image_filename: params[:signature_image_filename]
        ), 
        notice: 'Error while downloading. Send an email to the Call Center for any clarification'
      end
      
    end
  end

  def download_signature_image
    begin
      download_signature = Signature.find_by(signature_image_file_name: params[:signature_image_filename])

      download_file(
        download_signature.signature_image.path,
        download_signature.signature_image_file_name,
        download_signature.signature_image_content_type
      )
    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_success_path(
        solicitation_id: params[:solicitation_id],
        signature_image_filename: params[:signature_image_filename]
        ), 
        notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    end
  end

  def error
  end

  def success
  end

  def image
    filename = File.basename(params[:filename]) + ".#{params[:format]}"
    content = "image/png"
    path = File.join('signatures', filename)
    download_file(path, filename, content)
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

  def download_file(path, filename, content)
    send_file Rails.root.join('storage', path),
      :filename => filename,
      :type => content,
      :disposition => 'attachment'
  end
end
