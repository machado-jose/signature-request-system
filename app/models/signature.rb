class Signature < ApplicationRecord
  belongs_to :solicitation
  belongs_to :signatory

  has_attached_file :signature_image, {
    :url => "signatures/:hash.:extension",
    :path => "signatures/:hash.:extension",
    :hash_secret => "forestgump"
  }
  validates_attachment_content_type :signature_image, content_type: /\Aimage\/.*\z/

end
