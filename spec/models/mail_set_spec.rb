require 'rails_helper'

RSpec.describe MailSet, type: :model do
  it { should have_many :mails }

	it 'validates presence of mailset name' do
		expect(MailSet.new(name: '')).to_not be_valid
		expect(MailSet.new(name: 'Test set #1')).to be_valid
	end

	it 'validates length of mailset name' do
		expect(MailSet.new(name: 'Te')).to_not be_valid
		expect(MailSet.new(name: 'More than 24 characters should not valid')).to_not be_valid
		expect(MailSet.new(name: 'Just okay name for set')).to be_valid
	end
end
