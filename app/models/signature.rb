class Signature < ApplicationRecord
  belongs_to :solicitation
  belongs_to :signatory

  has_attached_file :signature_image
  validates_attachment_content_type :signature_image, content_type: /\Aimage\/.*\z/

end
