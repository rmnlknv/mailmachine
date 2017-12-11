class MailSet < ApplicationRecord
  has_many :emails
  belongs_to :user

  validates :name, presence: true, length: { in: 3..24 }

  before_save :format_addressee

  private

  def format_addressee
    # removes spaces that are more than 1 in a row, new lines and tabulations
    self.addressee = self.addressee.gsub(/[\r\n\t]/, ' ').gsub(/ {2,}/, ' ')
    self.addressee = self.addressee.split.select{ |a| a[/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i] }.uniq.join(' ')
  end
end
