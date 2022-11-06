FactoryBot.define do
  factory :office_image do
    office
    caption { '画像の説明テキストが入ります' }
    role { :carousel }

    after(:build) do |office_image|
      office_image.image.attach(io: Rails.root.join('spec/fixtures/test_image.jpg').open,
                                filename: 'test_image.jpg',
                                content_type: 'image/jpg')
    end
  end
end
