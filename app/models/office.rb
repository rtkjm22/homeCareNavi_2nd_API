class Office < ApplicationRecord
  include EnsureDestroyedByAssociation

  has_one :office_overview, dependent: :destroy
  # N+1に対処するため with_attached_image をスコープにする。
  # これにより office.office_images とした際に自動で includes({ image_attachment: :blob }) が実行され、N+1を回避できる。
  has_many :office_images, -> { with_attached_image }, inverse_of: :office, dependent: :destroy
  has_many :staffs, dependent: :destroy
  belongs_to :manager

  # Overrides::Registrationsコントローラーにて、Managerの新規作成時にoffice又はoffice_overviewが有効でなくても、
  # Managerの保存のみ成功してしまうが、下記を記述することでoffice_overviewが有効でないときはManagerの保存を失敗するようにする
  validates_associated :office_overview
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

  # 検索メソッドの先読みまたは遅延読み込みで使用する、関連付け配列
  SEARCH_ASSOCIATIONS = [:manager, :staffs, { office_images: { image_attachment: :blob } }].freeze

  # アドレスによる前方一致検索を実行する
  # @param [String] area 都道府県及び市区町村
  # @example
  #   Office.search_by_area("東京都新宿区市谷")
  scope :search_by_area, lambda { |area|
    eager_load(SEARCH_ASSOCIATIONS)
      .where(
        'users.address LIKE ?',
        # 参考: https://railsguides.jp/active_record_querying.html#%E6%9D%A1%E4%BB%B6%E3%81%A7like%E3%82%92%E4%BD%BF%E3%81%86
        "#{sanitize_sql_like(area)}%"
      )
      .order(:created_at)
  }

  # 引数として渡された緯度及び経度と、officeカラムのlat及びlngを比較し、近い順に並べ替える
  # @param [Float] lat 緯度
  # @param [Float] lng 経度
  # @see https://medium.com/%40hokan_dev/rails-%E3%81%82%E3%82%8B%E5%9C%B0%E7%82%B9%E3%81%AE%E7%B7%AF%E5%BA%A6%E7%B5%8C%E5%BA%A6%E3%81%8B%E3%82%89%E8%BF%91%E3%81%84%E9%A0%86%E3%81%AB%E3%82%BD%E3%83%BC%E3%83%88%E3%81%99%E3%82%8B-e3c1bff7a673
  scope :search_by_nearest, lambda { |lat, lng|
    # SQLインジェクション対策のため、強制的にFloat型に変換する
    lat = lat.to_f
    lng = lng.to_f
    includes(SEARCH_ASSOCIATIONS)
      .select("*, (
      6371 * acos(
          cos(radians(#{lat}))
          * cos(radians(lat))
          * cos(radians(lng) - radians(#{lng}))
          + sin(radians(#{lat}))
          * sin(radians(lat))
        )
      ) AS distance")
      .order(:distance)
  }
end
