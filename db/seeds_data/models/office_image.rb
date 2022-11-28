module Seed
  module OfficeImage
    def self.create_thumbnails
      office_ids = ::Office.ids
      puts "-----#{office_ids.count}枚のサムネイル画像作成-----"

      # OfficeImage作成
      thumbnail_array = []
      office_ids.each do |office_id|
        thumbnail_array << { office_id:, role: 0 } # 0は:thumbnail
      end
      office_image_ids = ::OfficeImage.insert_all!(thumbnail_array).to_a.pluck('id')

      # OfficeImageに紐づく画像データ作成
      thumbnail_attachment_array = []
      office_image_ids.each do |office_image_id|
        blob_id = ActiveStorage::Blob.create_and_upload!(
          io: File.open(Rails.root.join('db/seeds_data/images/thumbnail.jpg')), filename: "test_image_thumbnail_#{office_image_id}.jpg"
        ).id

        thumbnail_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_image_id, blob_id: }
      end
      ActiveStorage::Attachment.insert_all!(thumbnail_attachment_array)

      puts '-----サムネイル画像作成完了-----'
    end

    def self.create_carousels
      office_ids = ::Office.ids
      puts "-----#{office_ids.count * 5}枚のカルーセル画像作成-----"

      # 1つの事業所に対して5のOfficeImage作成
      carousel_array = []
      office_ids.each do |office_id|
        5.times { carousel_array << { office_id:, role: 1 } } # 1は:carousel
      end
      office_image_ids = ::OfficeImage.insert_all!(carousel_array).to_a.pluck('id')

      # OfficeImageに紐づく画像データ作成
      carousel_attachment_array = []
      office_image_ids.each_with_index do |office_image_id, i|
        carousel_i = i % 5 + 1  # 常に1~5の値。carousel1.jpg, carousel2.jpg...。 カルーセルファイル取得に使用
        blob_id = ActiveStorage::Blob.create_and_upload!(
          io: File.open(Rails.root.join("db/seeds_data/images/carousel#{carousel_i}.jpg")),
          filename: "test_image_carousel#{carousel_i}_#{office_image_id}.jpg"
        ).id

        carousel_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_image_id, blob_id: }
      end
      ActiveStorage::Attachment.insert_all!(carousel_attachment_array)

      puts '-----カルーセル画像作成完了-----'
    end

    def self.create_features
      office_ids = ::Office.ids
      puts "-----#{office_ids.count * 2}枚の特徴画像作成-----"

      # 1つの事業所に対して2のOfficeImage作成
      feature_array = []
      office_ids.each do |office_id|
        2.times { feature_array << { office_id:, caption: '画像の説明テキストが入ります', role: 2 } } # 2は:feature
      end
      office_image_ids = ::OfficeImage.insert_all!(feature_array).to_a.pluck('id')

      # OfficeImageに紐づく画像データ作成
      carousel_attachment_array = []
      office_image_ids.each_with_index do |office_image_id, i|
        feature_i = i % 2 + 1  # 常に1~2の値。feature1.jpg, feature2.jpg。 特徴ファイル取得に使用
        blob_id = ActiveStorage::Blob.create_and_upload!(
          io: File.open(Rails.root.join("db/seeds_data/images/feature#{feature_i}.jpg")),
          filename: "test_image_carousel#{feature_i}_#{office_image_id}.jpg"
        ).id

        carousel_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_image_id, blob_id: }
      end
      ActiveStorage::Attachment.insert_all!(carousel_attachment_array)

      puts '-----特徴画像作成完了-----'
    end
  end
end