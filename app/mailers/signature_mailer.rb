class SignatureMailer < ApplicationMailer
  def send_signature_request(signatory, url)
    @signatory = signatory
    @url = url
    mail(to: @signatory.email, subject: "Signature Request")
  end
end
