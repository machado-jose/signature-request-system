module AppServices
  class CryptSha256
    def initialize(data)
      @data = data.to_s
    end

    def call
      # Secret Key
      key = 'forestgump'
      digest = OpenSSL::Digest.new('sha256')
      crypt = OpenSSL::HMAC.hexdigest(digest, key, @data)
      OpenStruct.new({success?: true, crypt: crypt})
    end
  end
end