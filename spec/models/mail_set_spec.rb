require 'rails_helper'

RSpec.describe MailSet, type: :model do
  it { should have_many :mails }
  it { should belong_to :user }

  it { should validate_presence_of :name }

  it { should validate_length_of(:name).is_at_least(3) }
  it { should validate_length_of(:name).is_at_most(24) }

end
