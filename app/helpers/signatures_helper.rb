module SignaturesHelper
  def get_solicitation_id
    Solicitation.find(@signature[:solicitation_id]).id
  end

  def get_signatory_name
    Signatory.find(@signature[:signatory_id]).name
  end
end
