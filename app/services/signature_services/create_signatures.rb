module SignatureServices
  class CreateSignatures
    def initialize(solicitation_id)
      @solicitation_id = solicitation_id
    end

    def call
      begin
        Signatory.where(solicitation_id: @solicitation_id).each do |signatory|
          
          respost = AppServices::CryptSha256.new(signatory.id).call
          signature_token = respost.crypt
          url = 'http://localhost:3000/signature/' + signature_token
          
          new_signature = Signature.new 
          new_signature[:solicitation_id] = @solicitation_id
          new_signature[:signatory_id] = signatory.id
          new_signature[:url] = url
          new_signature[:signature_token] = signature_token
          new_signature.save!(validate: false)

          SignatureMailer.send_signature_request(signatory, new_signature).deliver_now
        end
      rescue => exception
        puts "[X] CreateSignatures#call: #{exception}"
        return OpenStruct.new({success?: false, error: 'CreateSignatures#call: Failed on Signatures Creation'})
      end
      return OpenStruct.new({success?: true})
    end
  end
end