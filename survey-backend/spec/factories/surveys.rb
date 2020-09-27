FactoryBot.define do
  factory :survey do
    survey_title { Faker::Lorem.word }
  end
end
