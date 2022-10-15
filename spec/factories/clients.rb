FactoryBot.define do
  factory :client do
    name { Gimei.name.kanji }
    email { Faker::Internet.safe_email }
    tel { Faker::PhoneNumber.cell_phone }
    address { Gimei.address.kanji }
    postal { Faker::Address.postcode.delete('-') }
    password { Faker::Internet.password }
    type { 'Client' }
    confirmed_at { Date.current.in_time_zone }
    discarded_at { nil }
  end
end
