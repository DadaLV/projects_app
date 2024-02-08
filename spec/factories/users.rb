FactoryBot.define do
  factory :user do
    email { "test@test.com" }
    password { "Password4@" }
    authentication_token { SecureRandom.base58(24) }
  end
end
