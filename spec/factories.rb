FactoryGirl.define do
  factory :group do
    name "MyString"
    user nil
  end
  factory :user do
    email "MyString"
    name "MyString"
  end
end
