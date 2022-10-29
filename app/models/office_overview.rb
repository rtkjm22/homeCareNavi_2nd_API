class OfficeOverview < ApplicationRecord
  include EnsureDestroyedByAssociation

  belongs_to :office
  validates :office_id, uniqueness: true
  validates :classify, length: { maximum: 200 }
  validates :requirements, length: { maximum: 200 }
  validates :shared_facilities, length: { maximum: 200 }
  validates :business_entity, length: { maximum: 200 }
  validates :official_site_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_nil: true
end
