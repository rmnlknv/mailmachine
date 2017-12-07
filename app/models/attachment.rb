class Attachment < ApplicationRecord
  belongs_to :mail
  mount_uploader :file, FileUploader
end
