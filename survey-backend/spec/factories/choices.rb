FactoryBot.define do
  factory :choice do
    choice_title { Faker::Lorem.word }
    question_id { nil }
  end
end
