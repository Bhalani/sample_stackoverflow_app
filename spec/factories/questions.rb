FactoryBot.define do
  factory :question do
    user
    title { Faker::Movies::HarryPotter.book }
    description { Faker::Lorem.paragraph }
  end
end
