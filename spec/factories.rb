require 'faker'

FactoryGirl.define do
  factory :notification do
    versions_changed "MyString"
    user nil
  end
  factory :version do
    title "MyString"
    images "MyText"
    features "MyText"
    reviews_number 1
    best_seller_rank 1
    best_seller_category "MyString"
    asin "MyString"
    price 1.5
    product nil
  end
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
    email Faker::Internet.email
    name "Name"
    password Faker::Internet.password
  end
end
