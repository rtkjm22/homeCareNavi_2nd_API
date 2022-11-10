class OfficeImage < ApplicationRecord
  belongs_to :office
  has_one_attached :image

  validates :caption, length: { maximum: 200 }
  validates :image, attached: true, content_type: { in: %w[image/jpg image/jpeg image/png] },
                    size: { less_than: 5.megabytes }
  validates :role, presence: true

  # サムネイルは1枚、カルーセルは5枚、詳細は2枚を上限とするバリデーション
  validate do
    count = OfficeImage.where(office_id:, role:).count
    new_image = { role:, count: }
    has_error =
      case new_image
      in  { role: 'thumbnail', count: 1.. } |
          { role: 'carousel', count: 5.. } |
          { role: 'feature', count: 2.. }
        true
      else
        false
      end
    errors.add(role_i18n, "は#{new_image[:count]}枚のみ保存できます") if has_error
  end

  # thumbnail: 一覧検索時のサムネイル
  # carousel: 詳細画面の5枚のカルーセル
  # feature: 詳細画面の2枚の特徴画像
  enum role: { thumbnail: 0, carousel: 1, feature: 2 }

  # 紐付いている画像のURLを取得する
  def image_url
    image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil
  end

  # { image_url: URL } をレスポンスのjsonに含めるようにする
  def as_json(options = {})
    super(options.merge(methods: :image_url))
  end
end
