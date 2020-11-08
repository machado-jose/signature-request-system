module SolicitationsHelper
  def get_solicitation_status(solicitation)
    signatures_list = Signature.where(:solicitation_id => solicitation.id).to_a
    if signatures_list.all?{|signature| signature.is_signed}
      'Approved'
    elsif signatures_list.any?{|signature| signature.denied}
      'Denied'
    else 
      'Pending'
    end
  end
end
