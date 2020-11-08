class SignaturesController < ApplicationController
  attr_accessor :signature_image_path, :signature_file_name, :signature_content_type

  def index
    @signature = signature_valid(params[:signature_id])
    if @signature.blank?
      redirect_to signature_error_path
    end
    @signature
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
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_path(params[:signature_id]), notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    end
  end

  def download_signature_image
    begin
      download_signature = Signature.find_by(signature_image_file_name: params[:signature_image_filename]+'.'+params[:format])

      download_file(
        download_signature.signature_image.path,
        download_signature.signature_image_file_name,
        download_signature.signature_image_content_type
      )
    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_success(params[:signature_image_filename]), notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    end
  end

  def error
  end

  def success
  end

  def submit
    params_signature = get_signature_params
    respost = SignatureServices::UpdateSignatureValidation.new(params_signature).call
    if respost.success?
      redirect_to signature_success_path(
        signature_image_filename: respost.signature.signature_image_file_name,
        solicitation_id: params_signature[:solicitation_id]
      )
    else
      redirect_to signature_error_path
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

  def download_file(path, filename, content)
    send_file Rails.root.join('storage', path),
      :filename => filename,
      :type => content,
      :disposition => 'attachment'
  end
end
