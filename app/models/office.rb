class Office < ApplicationRecord
  include EnsureDestroyedByAssociation

  has_one :office_overview, dependent: :destroy
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
end
