class Office < ApplicationRecord
  include EnsureDestroyedByAssociation

  has_one :office_overview, dependent: :destroy
  # N+1に対処するため with_attached_image をスコープにする。
  # これにより office.office_images とした際に自動で includes({ image_attachment: :blob }) が実行され、N+1を回避できる。
  has_many :office_images, -> { with_attached_image }, dependent: :destroy
  belongs_to :manager

  validates :manager_id, uniqueness: true
  validates :name, presence: true, length: { maximum: 200 }
  validates :feature_title, presence: true, length: { maximum: 200 }
  validates :feature_detail, presence: true
  validates :workday_detail, presence: true
  validates :lat, numericality: true, allow_nil: true
  validates :lng, numericality: true, allow_nil: true
  validates :fax, presence: true, length: { maximum: 200 }
  validates :nearest_station, presence: true

  flag :workday, %i[sun mon tue wed thu fri sat]

  # アドレスによる前方一致検索を実行する
  # @param [String] area 都道府県及び市区町村
  # @example
  #   Office.search_by_area("東京都新宿区市谷")
  scope :search_by_area, lambda { |area|
    eager_load(:manager, { office_images: { image_attachment: :blob } })
      .where(
        'users.address LIKE ?',
        # 参考: https://railsguides.jp/active_record_querying.html#%E6%9D%A1%E4%BB%B6%E3%81%A7like%E3%82%92%E4%BD%BF%E3%81%86
        "#{sanitize_sql_like(area)}%"
      )
      .order(:created_at)
  }
end
