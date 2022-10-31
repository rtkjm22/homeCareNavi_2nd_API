class OfficeImage < ApplicationRecord
  belongs_to :office
  has_one_attached :image

  validates :caption, length: { maximum: 200 }
  validates :role, presence: true
  validates :image, attached: true, content_type: { in: %w[image/jpg image/jpeg image/png] },
                    size: { less_than: 5.megabytes }

  # thumbnail: 一覧検索時のサムネイル
  # carousel: 詳細画面の5枚のカルーセル
  # feature: 詳細画面の2枚の特徴画像
  enum role: { thumbnail: 0, carousel: 1, feature: 2 }

  # 紐付いている画像のURLを取得する
  def image_url
    image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil
  end
end
