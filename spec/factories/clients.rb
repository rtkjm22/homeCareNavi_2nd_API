FactoryBot.define do
  factory :client do
    name { Gimei.name.kanji }
    sequence(:email) { |i| "client#{i}@example.com" }
    tel { Faker::PhoneNumber.cell_phone }
    address { Gimei.address.kanji }
    postal { Faker::Address.postcode.delete('-') }
    password { Faker::Internet.password }
    type { 'Client' }
    confirmed_at { Date.current.in_time_zone }
  end
end
