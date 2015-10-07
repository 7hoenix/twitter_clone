FactoryGirl.define do
  factory :user do
    name "Justin"
    email "justin@example.com"
    password User.digest("password")
  end
end
