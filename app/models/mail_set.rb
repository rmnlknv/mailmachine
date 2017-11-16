class MailSet < ApplicationRecord
	validates :name, presence: true, length: { in: 3..24 }
end
