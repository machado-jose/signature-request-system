class AddAttachmentDocumentToSolicitations < ActiveRecord::Migration[5.1]
  def self.up
    change_table :solicitations do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :solicitations, :document
  end
end
