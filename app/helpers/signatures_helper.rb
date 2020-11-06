module SignaturesHelper
  def get_solicitation_id
    Solicitation.find(@signature[:solicitation_id]).id
  end
end
