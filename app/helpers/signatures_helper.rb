module SignaturesHelper
  def get_document_token
    Solicitation.find(@signature[:solicitation_id]).document_token
  end
  def get_signatory_name
    Signatory.find(@signature[:signatory_id]).name
  end
end
