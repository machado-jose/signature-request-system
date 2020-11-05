class SignaturesController < ApplicationController

  def index
    @signatory = Signatory.find_by(id: params[:signatory_id])
    unless @signatory
      render :error
    end
    @signatory
  end

  def download_file
    begin
      download_file = Solicitation.find(params[:solicitation_id])

      send_file Rails.root.join('torage', download_file.document.path),
      :filename => download_file.document_file_name,
      :type => download_file.document_content_type,
      :disposition => 'attachment'

    rescue ActionController::MissingFile, ActiveRecord::RecordNotFound => exception
      puts "[X] Error in signatures#download_file: #{exception}"
      render :index
    end
  end

  def error
  end
end
