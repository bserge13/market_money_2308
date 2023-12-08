FactoryBot.define do
  factory :vendor do
    name { Faker::TvShows::SiliconValley.company }
    description { Faker::Lorem.paragraph }
    contact_name { Faker::TvShows::SiliconValley.character }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { Faker::Boolean.boolean}
  end
end