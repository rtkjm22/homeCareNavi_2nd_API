# frozen_string_literal: true

require 'net/http'

module HeartRailsGeoApi
  HEART_RAILS_GEO_API_BASE_URL = 'http://geoapi.heartrails.com/api/json'

  # 郵便番号から住所情報を取得する
  def search_by_postal(postal)
    uri = URI.parse(HEART_RAILS_GEO_API_BASE_URL + "?method=searchByPostal&postal=#{postal}")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  # 郵便番号から最寄り駅を取得する
  def get_stations(postal)
    uri = URI.parse(HEART_RAILS_GEO_API_BASE_URL + "?method=getStations&postal=#{postal}")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end
end
