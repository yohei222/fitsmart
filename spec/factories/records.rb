FactoryBot.define do
  factory :record do
    weight 30
    times 25
    sets 3
    exercise_id 1
    association :micropost
  end
end
