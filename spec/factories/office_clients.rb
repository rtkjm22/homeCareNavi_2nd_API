FactoryBot.define do
  factory :office_client do
    transient do
      gimei_name { Gimei.name }
    end

    staff
    name { gimei_name.kanji }
    age { 70 }
    furigana { gimei_name.hiragana }
    postal { '0010010' }
    address { '北海道札幌市北区北十条西' }
    family { '娘' }

    # アバター画像付き
    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_image.jpg'), 'image/jpeg') }
    end
  end
end
