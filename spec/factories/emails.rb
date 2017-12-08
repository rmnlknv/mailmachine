FactoryGirl.define do
  factory :email do
    title "MyString"
    body "MyText"
  end

  factory :invalid_email, class: "Email" do
  	title "This is invalid title for mail, because it is too long for title"
  	body nil
  end
end
