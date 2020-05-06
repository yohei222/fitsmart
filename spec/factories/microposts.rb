FactoryBot.define do
  factory :micropost do
    sequence(:title) { |n| "筋トレ#{n}日目" }
    content "筋トレアプリfitsmart"
    association :user
  end
end
