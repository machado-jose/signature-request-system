class SignatureMailer < ApplicationMailer
  def send_signature_request(signatory, new_signature)
    @signatory = signatory
    @new_signature = new_signature
    mail(to: @signatory.email, subject: "Signature Request")
  end
end
