class AddAttachmentDocumentToReports < ActiveRecord::Migration
  def self.up
    change_table :reports do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :reports, :document
  end
end
