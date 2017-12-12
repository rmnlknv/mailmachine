require 'rails_helper'

RSpec.describe History, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :email_title }
  it { should validate_presence_of :email_id }
  it { should validate_presence_of :queued }
  it { should validate_presence_of :recipients_amount }

end

