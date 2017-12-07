class MailSet < ApplicationRecord
  has_many :mails
  belongs_to :user

  validates :name, presence: true, length: { in: 3..24 }
  before_save :format_addressee

  private

  def format_addressee
    # removes spaces that are more than 1 in a row, new lines and tabulations
    self.addressee = self.addressee.gsub(/[\r\n\t]/, ' ').gsub(/ {2,}/, ' ')
  end
end
