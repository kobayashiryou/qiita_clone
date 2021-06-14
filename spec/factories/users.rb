FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    nickname { Faker::Internet.username}
    password { Faker::Internet.password(min_length: 8, max_length: 32)}
  end
end
