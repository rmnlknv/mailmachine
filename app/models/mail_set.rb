class MailSet < ApplicationRecord
	has_many :mails
	
	validates :name, presence: true, length: { in: 3..24 }
end
