class SignaturesController < ApplicationController
  def index
    if Signatory.exists?(params[:signatory_id])
      @signatory = Signatory.find(params[:signatory_id])
    else
      # Error Page
      puts ">>>>>>>>>>>>>>>> Erro Index Sign"
      render :index
    end 
  end

  def download_file
    download_file = Solicitation.find(params[:solicitation_id])
    send_file Rails.root.join('storage', download_file.document.path),
    :filename => download_file.document_file_name,
    :type => download_file.document_content_type,
    :disposition => 'attachment'
  end
end
