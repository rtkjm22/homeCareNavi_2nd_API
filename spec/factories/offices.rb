FactoryBot.define do
  factory :office do
    manager
    sequence(:name) { |i| "ホームケア事務所_#{i}" }
    feature_title { '事業所紹介タイトル' }
    feature_detail { 'ここに事業所の特徴テキストが入ります' }
    workday { %i[mon tue wed thu fri] }
    workday_detail { '営業日時についてのテキストが入ります' }
    lat { rand(-90.000000000...90.000000000) }
    lng { rand(-180.000000000...180.000000000) }
    fax { '111-2222-3333' }
    nearest_station { '祖師谷大倉駅 徒歩5分' }
  end
end
