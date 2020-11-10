module SignatureServices
  class UpdateSignature
    def initialize(params)
      @signature_image = params[:signature_image]
      @justification = params[:justification]
      @signature_id = params[:id]
      @solicitation_id = params[:solicitation_id]
    end

    def call
      # Just one field must have information
      if @signature_image.empty? ^ @justification.empty?
        # Checks whether the signature request exists from the information given
        signature = signature_exists?
        # Checks if the signature request has already been completed
        if signature_is_closed?(signature)
          return handle_error('UpdateSignatureValidation#call: Signature has already been completed.')
        end
        # Update signature
        unless @signature_image.empty?
          return SignatureServices::UploadSignatureImage.new(@signature_image, signature).call
        else 
          begin
            signature.update!(
              :justification => @justification,
              :denied => true
            )
            OpenStruct.new({
              success?: true, 
              signature: signature, 
              status: 'denied'
            })
          rescue => exception
            puts "[X] UpdateSignatureValidation#call: #{exception.message}"
            handle_error('UpdateSignatureValidation#call: Or Signature Image field or justification field must filled.')
          end
        end
      else
        handle_error('UpdateSignatureValidation#call: Or Signature Image field or justification field must filled.')
      end
    end
    
    private

    def handle_error(error)
      OpenStruct.new({success?: false, error: error})
    end

    def signature_exists?
      signature = Signature.where(:id => @signature_id, :solicitation_id => @solicitation_id)[0]
      signature.blank? ? handle_error('UpdateSignatureValidation#signature_valid: Invalid Datas') : signature
    end

    def signature_is_closed?(signature)
      signature.is_signed || signature.denied
    end
  end 
end