FactoryGirl.define do
  factory :mail do
    title "MyString"
    body "MyText"
  end

  factory :invalid_mail, class: "Mail" do
  	title "This is invalid title for mail, because it is too long for title"
  	body nil
  end
end
