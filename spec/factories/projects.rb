FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    user
  end
end
