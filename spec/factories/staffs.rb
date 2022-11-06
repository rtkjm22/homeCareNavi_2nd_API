FactoryBot.define do
  factory :staff do
    office { nil }
    name { Gimei.name.kanji }
    furigana { Gimei.name.hiragana }
    introduction { Faker::Lorem.sentence(sentence_count: 7) }
    role { worker }
  end
end
