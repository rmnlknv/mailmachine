class Mail < ApplicationRecord
  belongs_to :mail_set
  belongs_to :user

  validates :title, presence: true, length: { in: 3..24 }
  validates :body, presence: true, length: { in: 3..1000 }

end
