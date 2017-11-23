class Mail < ApplicationRecord
  belongs_to :mail_set

  validates :title, presence: true, length: { in: 3..24 }
  validates :body, presence: true, length: { in: 3..1000 }

end
