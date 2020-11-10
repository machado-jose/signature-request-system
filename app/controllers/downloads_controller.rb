class DownloadsController < ApplicationController

  def download_document
    begin
      solicitation = Solicitation.find_by(:document_token => params[:document_token])
      download_file(
        solicitation.document.path,
        solicitation.document_file_name,
        solicitation.document_content_type
      )
    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      url = Signature.find(params[:signature_id])
      redirect_to url, notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    rescue => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_error_path
    end
  end

  def download_signature
    begin
      signature = Signature.find_by(:signature_token => params[:signature_token])
      download_file(
        signature.signature_image.path,
        signature.signature_image_file_name,
        signature.signature_image_content_type
      )
    rescue => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      redirect_to signature_success_path(:signature_token => params[:signature_token]), 
        notice: 'Error while downloading. Send an email to the Call Center for any clarification'
    end
  end

  private

  def download_file(path, filename, content)
    send_file Rails.root.join('storage', path),
      :filename => filename,
      :type => content,
      :disposition => 'attachment'
  end
end
