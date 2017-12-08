require 'rails_helper'

RSpec.describe Email, type: :model do
  it { should belong_to :mail_set }
  it { should belong_to :user }
  it { should have_many :attachments }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }
end

