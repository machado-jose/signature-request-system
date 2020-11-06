class Signature < ApplicationRecord
  belongs_to :document
  belongs_to :signatory

  scope :signature_valid, -> (signature_id) {
    where(:id => 1, :is_signed => false, :denied => false)[0]
  }
end
