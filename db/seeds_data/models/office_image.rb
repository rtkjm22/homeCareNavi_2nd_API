module Seed
  module OfficeImage
    def self.create_thumbnails
      office_ids = ::Office.ids
      puts "-----#{office_ids.count}枚のサムネイル画像作成-----"

      thumbnail_array = []
      thumbnail_attachment_array = []
      office_ids.each do |office_id|
        thumbnail_array << { office_id:, role: 0 } # 0は:thumbnail

        blob_id = ActiveStorage::Blob.create_and_upload!(
          io: File.open(Rails.root.join('db/seeds_data/images/thumbnail.jpg')), filename: "test_image_thumbnail_#{office_id}.jpg"
        ).id

        thumbnail_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_id, blob_id: }
      end
      ::OfficeImage.insert_all!(thumbnail_array)
      ActiveStorage::Attachment.insert_all!(thumbnail_attachment_array)

      puts '-----サムネイル画像作成完了-----'
    end

    def self.create_carousels
      office_ids = ::Office.ids
      puts "-----#{office_ids.count * 5}枚のカルーセル画像作成-----"

      carousel_array = []
      carousel_attachment_array = []
      office_ids.each do |office_id|
        carousel_array << { office_id:, role: 1 } # 1は:thumbnail

        blob_ids = []
        (1..5).each do |i|
          blob_ids << ActiveStorage::Blob.create_and_upload!(
            io: File.open(Rails.root.join("db/seeds_data/images/carousel#{i}.jpg")), filename: "test_image_carousel#{i}_#{office_id}.jpg"
          ).id
        end

        blob_ids.each do |blob_id|
          carousel_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_id, blob_id: }
        end
      end
      ::OfficeImage.insert_all!(carousel_array)
      ActiveStorage::Attachment.insert_all!(carousel_attachment_array)

      puts '-----カルーセル画像作成完了-----'
    end

    def self.create_features
      office_ids = ::Office.ids
      puts "-----#{office_ids.count * 2}枚の特徴画像作成-----"

      feature_array = []
      feature_attachment_array = []
      office_ids.each do |office_id|
        feature_array << { office_id:, caption: '画像の説明テキストが入ります', role: 2 } # 2は:feature

        blob_ids = []
        (1..2).each do |i|
          blob_ids << ActiveStorage::Blob.create_and_upload!(
            io: File.open(Rails.root.join("db/seeds_data/images/feature#{i}.jpg")), filename: "test_image_feature#{i}_#{office_id}.jpg"
          ).id
        end

        blob_ids.each do |blob_id|
          feature_attachment_array << { name: 'image', record_type: 'OfficeImage', record_id: office_id, blob_id: }
        end
      end
      ::OfficeImage.insert_all!(feature_array)
      ActiveStorage::Attachment.insert_all!(feature_attachment_array)

      puts '-----特徴画像作成完了-----'
    end
  end
end