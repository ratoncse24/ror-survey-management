FactoryBot.define do
  factory :question do
    question_title { Faker::Lorem.word }
    survey_id { nil }
    option_type { nil }
  end
end
