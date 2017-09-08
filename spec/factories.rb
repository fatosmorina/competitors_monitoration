FactoryGirl.define do
  factory :product do
    asin "MyString"
    last_checked "2017-09-08"
    group nil
  end
  factory :group do
    name "MyString"
    user nil
  end
  factory :user do
    email "MyString"
    name "MyString"
  end
end
