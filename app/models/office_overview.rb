class OfficeOverview < ApplicationRecord
  belongs_to :office
  validates :office_id, uniqueness: true
  validates :official_site_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_nil: true
end
