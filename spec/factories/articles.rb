FactoryBot.define do
  factory :article do
    title { Faker::String }
    body { Faker::String }
  end
end
