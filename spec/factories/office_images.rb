FactoryBot.define do
  factory :office_image do
    office
    caption { '画像の説明テキストが入ります' }
    role { 0 }
  end
end
