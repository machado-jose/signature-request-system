class Signature < ApplicationRecord
  belongs_to :document
  belongs_to :signatory
end
