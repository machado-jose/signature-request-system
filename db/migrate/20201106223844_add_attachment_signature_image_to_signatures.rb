class AddAttachmentSignatureImageToSignatures < ActiveRecord::Migration[5.1]
  def self.up
    change_table :signatures do |t|
      t.attachment :signature_image
    end
  end

  def self.down
    remove_attachment :signatures, :signature_image
  end
end
