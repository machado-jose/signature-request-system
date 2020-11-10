module SolicitationServices
  class CreateSolicitation
    def initialize(params)
      @params = params
    end

    def call
      begin
        solicitation = Solicitation.new(@params)
        key = solicitation.id.to_s + @params[:document].original_filename 
        respost = AppServices::CryptSha256.new(key).call
        document_token = respost.crypt
        solicitation.update(:document_token => document_token)
        OpenStruct.new({success?: true, solicitation: solicitation})
      rescue => exception
        puts "[X] CreateSolicitation#call: #{exception}"
        return OpenStruct.new({success?: false, error: 'CreateSolicitation#call: Failed on Solicitation Creation'})
      end
    end
  end
end