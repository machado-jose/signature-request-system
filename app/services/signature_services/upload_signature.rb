module SignatureServices
  class UploadSignature
    def initialize(signature_image, signature)
      @signature_image = signature_image
      @signature = signature
    end

    def call
      signature_image = Paperclip.io_adapters.for(@signature_image)
      signature_image.original_filename = "signature_img_solicitation_#{@signature.solicitation_id}_signature_#{@signature.id}.png"
      begin
        @signature.update!(
          :is_signed => true,
          :signature_image => signature_image
        )
        OpenStruct.new({success?: true, signature: @signature})
      rescue => exception
        OpenStruct.new({success?: false, error: 'UploadSignature#call: Failed to update data'})
      end
    end
  end
end