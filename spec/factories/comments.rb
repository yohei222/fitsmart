FactoryBot.define do
  factory :comment do
    content "コメントです"
    association :user
    association :micropost
  end
end
