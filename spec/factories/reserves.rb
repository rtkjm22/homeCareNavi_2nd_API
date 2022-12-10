FactoryBot.define do
  factory :reserve do
    transient do
      gimei_name { Gimei.name }
    end

    office
    client
    interview_begin_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 100) }
    interview_end_at { Faker::Time.between(from: DateTime.now , to: DateTime.now + 100) }
    user_name { gimei_name.kanji }
    user_age {Faker::Number.within(range: 1..150) }
    contact_tel { Faker::PhoneNumber.cell_phone }
    note { Faker::Lorem.sentence(word_count: 25) }
    is_contacted { false }
  end
end

