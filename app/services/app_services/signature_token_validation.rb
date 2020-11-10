module AppServices
  class SignatureTokenValidation
    def initialize(signature_token)
      @signature_token = signature_token
    end

    def call
      signature = Signature.where(
        :signature_token => @signature_token, 
        :is_signed => false, 
        :denied => false
      ).first
      if signature.blank?
        OpenStruct.new({success?: false, error: 'Signature Token invalid.'})
      else 
        unless Solicitation.find_by(:id => signature.solicitation_id).is_canceled
          OpenStruct.new({success?: true, signature: signature})
        else 
          OpenStruct.new({success?: false, error: 'Solicitation was canceled.'})
        end
      end
    end
  end
end