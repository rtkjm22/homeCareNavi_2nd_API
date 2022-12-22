FactoryBot.define do
  factory :manager do
    name { Gimei.name.kanji }
    sequence(:email) { |i| "manager#{i}@example.com" }
    tel { Faker::PhoneNumber.cell_phone }
    address { '北海道札幌市北区北十条西' }
    postal { '0010010' }
    password { Faker::Internet.password }
    type { 'Manager' }
    confirmed_at { Date.current.in_time_zone }
  end
end
