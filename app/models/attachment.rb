class Attachment < ApplicationRecord
  belongs_to :email
  mount_uploader :file, FileUploader
end
