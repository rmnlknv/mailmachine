class History < ApplicationRecord
 belongs_to :user

 validates :email_title, presence: true
 validates :email_id, presence: true
 validates :queued, presence: true
 validates :recipients_amount, presence: true

 scope :delivered,   -> { where(sent: true) }
 scope :not_delivered,   -> { where(sent: false) }
 
end
