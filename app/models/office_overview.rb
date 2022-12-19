class OfficeOverview < ApplicationRecord
  include EnsureDestroyedByAssociation

  belongs_to :office
  validates :office_id, uniqueness: true
  validates :classify, length: { maximum: 200 }
  validates :requirements, length: { maximum: 200 }
  validates :room_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :shared_facilities, length: { maximum: 200 }
  validates :business_entity, length: { maximum: 200 }
  validates :official_site_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_nil: true
  # opening_dateが未来の日付の場合はエラー。nilは許可する。
  validate :opening_date do
    has_error = opening_date.present? && opening_date > Date.current
    errors.add(:opening_date, 'に未来の日付を入力することは出来ません') if has_error
  end
end
