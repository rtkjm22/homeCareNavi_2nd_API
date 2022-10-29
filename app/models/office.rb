class Office < ApplicationRecord
  has_one :office_overview, dependent: :destroy
  belongs_to :manager

  validates :manager_id, uniqueness: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :feature_title, presence: true, length: { maximum: 100 }
  validates :feature_detail, presence: true
  validates :workday_detail, presence: true
  validates :lat, numericality: true
  validates :lng, numericality: true
  validates :fax, presence: true
  validates :nearest_station, presence: true

  flag :workday, %i[sun mon tue wed thu fri sat]
end
