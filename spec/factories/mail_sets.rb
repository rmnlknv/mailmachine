FactoryGirl.define do
  factory :mail_set do
    name "MyString"
    addressee "MyText"
  end

  factory :invalid_mail_set, class: "MailSet" do
  	name "It is too long name for mail set, that's why it is invalid"
  	addressee "MyText"
  end
end
