FactoryBot.define do
  factory :office_overview do
    office
    classify { '介護付きホーム（サービス付き高齢者向け住宅　特定施設）' }
    opening_date { '2022-3-11' }
    room_count { 30 }
    requirements { '満60歳以上の方、入居時自立・要支援・要介護' }
    shared_facilities { 'エントランス、食堂兼機能訓練室、個浴、大浴場、特殊浴槽、和室、談話室、シアタールーム、屋上庭園' }
    business_entity { '株式会社ユニマット　リタイアメント・コミュニティ' }
    official_site_url { 'https://www.unimat-rc.co.jp/shisetsu/sosigaya_871/index.html' }
  end
end
