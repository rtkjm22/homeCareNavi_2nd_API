class OfficeImage < ApplicationRecord
  belongs_to :office
  has_one_attached :image

  validates :caption, length: { maximum: 200 }
  validates :role, presence: true

  # thumbnail: 一覧検索時のサムネイル
  # carousel: 詳細画面の5枚のカルーセル
  # feature: 詳細画面の2枚の特徴画像
  enum role: { thumbnail: 0, carousel: 1, feature: 2 }
end
