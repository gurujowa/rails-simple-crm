require 'file_size_validator'
class LeadHistoryAttachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  validates :attachment, file_size: {maximum: 10.megabytes.to_i}
  belongs_to :lead_history
end
