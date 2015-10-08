FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name "User"
    email
    password User.digest("password")
  end
end
