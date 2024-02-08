# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

User.create(email: 'user1@example.com', password: 'password123')
User.create(email: 'user2@example.com', password: 'password456')

10.times do
  Project.create(
    name: Faker::App.name,
    description: Faker::Lorem.sentence,
    user_id: rand(1..2)
  )
end

Project.all.each do |project|
  5.times do
    Task.create(
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence,
      status: ['new', 'in_progress', 'completed'].sample,
      project_id: project.id
    )
  end
end
