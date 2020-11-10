# Signature Request System

This system aims to enable customers and employees to digitally sign company documents.

* Ruby version: 2.6.6
* Rails version: 5.1.4

## Models
* Solicitation
* Signatory
* Signature

## Controllers
* Application
* Solicitations
* Signatures
* Downloads

# Mailers
* SignatureMailer

## Services
### AppServices
  * CryptSha256
  * SignatureTokenValidation
### SignatureServices
  * CreateSignatures
  * UpdateSignatures
  * UploadSignatureImage
### SolicitationServices
  * CreateSolicitation

## Gems
* Cocoon
* Paperclip
* Fog (local)
* I18n
* Kaminari

## Observations
* The files are being stored in the **storage folder**, at the root of the application.
