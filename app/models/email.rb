class Email < ApplicationRecord
  belongs_to :mail_set
  belongs_to :user
  has_many :attachments

  validates :title, presence: true, length: { in: 3..24 }
  validates :body, presence: true, length: { in: 3..1000 }

  accepts_nested_attributes_for :attachments
end
