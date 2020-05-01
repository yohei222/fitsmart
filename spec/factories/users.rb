FactoryBot.define do
  factory :user do
    status { 1 }
    sex { 1 }
    name { "Test User" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :user_email, class: User do
    name { "Andrew" }
    email { "duchess@example.gov" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end

  factory :user_nonreleased, class: User do
    name { "Andrew" }
    email { "duchess@example.gov" }
    status { "nonreleased" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end

end