class Solicitation < ApplicationRecord
  belongs_to :document
  has_many :signatories
  accepts_nested_attributes_for :signatories, reject_if: :all_blank, allow_destroy: true
end
