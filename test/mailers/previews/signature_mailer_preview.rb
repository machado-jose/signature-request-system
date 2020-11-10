# Preview all emails at http://localhost:3000/rails/mailers/signature_mailer
class SignatureMailerPreview < ActionMailer::Preview
  def send_signature_request    
    SignatureMailer.send_signature_request(Signatory.last, Signature.last) 
  end
end
