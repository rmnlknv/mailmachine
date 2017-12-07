class MailSet < ApplicationRecord
	has_many :mails
	belongs_to :user
	
	validates :name, presence: true, length: { in: 3..24 }
end
