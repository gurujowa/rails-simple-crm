class CreateLeadHistoryAttachments < ActiveRecord::Migration
  def change
    create_table :lead_history_attachments do |t|
      t.integer :lead_history_id, nil: false
      t.string :attachment, nil: false

      t.timestamps
    end
  end
end
