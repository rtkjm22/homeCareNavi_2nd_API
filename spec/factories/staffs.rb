FactoryBot.define do
  factory :staff do
    transient do
      gimei_name { Gimei.name }
    end

    office
    name { gimei_name.kanji }
    furigana { gimei_name.hiragana }
    introduction { Faker::Lorem.sentence(word_count: 25) }
    role { 'care_manager' }
  end
end
