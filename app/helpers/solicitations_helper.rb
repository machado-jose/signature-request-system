module SolicitationsHelper
  def get_solicitation_status(solicitation)
    unless solicitation.is_canceled
      signatures_list = Signature.where(:solicitation_id => solicitation.id).to_a
      if signatures_list.all?{|signature| signature.is_signed}
        'Approved'
      elsif signatures_list.any?{|signature| signature.denied}
        'Denied'
      else 
        'Pending'
      end
    else 
      'Canceled'
    end
  end

  def get_signatories(solicitation_id)
    Signatory.where(:solicitation_id => solicitation_id).to_a
  end

  def get_signature(signatory_id)
    Signature.find_by(:signatory_id => signatory_id)
  end

  def get_signature_status(signature)
    if signature.is_signed
      'Signed'
    elsif signature.denied
      'Denied'
    else 
      'In analysis'
    end
  end
end
