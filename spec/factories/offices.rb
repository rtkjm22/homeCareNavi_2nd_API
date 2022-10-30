FactoryBot.define do
  factory :office do
    manager
    sequence(:name) { 'ホームケア事務所_1' }
    feature_title { '事業所紹介タイトル' }
    feature_detail { 'ここに事業所の特徴テキストが入ります' }
    workday { 0 }
    workday_detail { '営業日時についてのテキストが入ります' }
    lat { 43.073211 }
    lng { 141.350427 }
    fax { '111-2222-3333' }
    nearest_station { '札幌市南北線 北12条駅' }
  end
end
