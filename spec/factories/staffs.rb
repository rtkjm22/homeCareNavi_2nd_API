FactoryBot.define do
  factory :staff do
    office
    name { Gimei.name.kanji }
    furigana { Gimei.name.hiragana }
    introduction { Faker::Lorem.sentence(word_count: 25) }
    role { 1 }
  end
end
