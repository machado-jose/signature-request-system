class Solicitation < ApplicationRecord
  has_many :signatories
  accepts_nested_attributes_for :signatories, reject_if: :all_blank, allow_destroy: true
  has_attached_file :document
  validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

  # Kaminari Pagination  
  paginates_per 5
end
