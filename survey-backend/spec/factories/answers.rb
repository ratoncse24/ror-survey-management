FactoryBot.define do
  factory :answer do
    answer_text { Faker::Lorem.word }
    question_id { nil }
  end
end
