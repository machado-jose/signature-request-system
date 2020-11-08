module SignatureServices
  class UpdateSignatureValidation
    def initialize(params)
      @signature_image = params[:signature_image]
      @justification = params[:justification]
      @signature_id = params[:id]
      @solicitation_id = params[:solicitation_id]
    end

    def call
      if @signature_image.empty? ^ @justification.empty?
        signature = signature_exists?
        if signature_is_closed?(signature)
          handle_error('UpdateSignatureValidation#call: Signature has already been completed')
        end
        unless @signature_image.empty?
          respost = SignatureServices::UploadSignature.new(@signature_image, signature).call
          respost
        end
      else
        handle_error('UpdateSignatureValidation#call: Or signature_image field or justification field must filled.')
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