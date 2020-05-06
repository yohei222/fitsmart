FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}oclockyohey@gmail.com" }
    name "ようへい"
    password "password"

    # trait :email_nil do
    #   email nil
    # end
  end
end
