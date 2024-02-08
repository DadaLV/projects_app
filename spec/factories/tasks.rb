FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status { 'Task::STATUS.sample' }
    project
  end
end
