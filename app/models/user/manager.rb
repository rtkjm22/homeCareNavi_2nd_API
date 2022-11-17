# frozen_string_literal: true

class Manager < User
  include HeartRailsGeoApi
  has_one :office, dependent: :destroy

  # オフィスの経度緯度及び最寄り駅を埋めた上でbuildする
  # 郵便番号によってはヒットしないこともあるので、その場合はエラーにせず、
  # 登録後に編集画面でユーザーに手入力してもらう
  def build_office_with_location
    fetch_lat_lng(postal) => { x:, y: }
    fetch_station(postal) => { name:, distance: }

    # 1分間に80mとして徒歩○分の時間を求める。distanceが存在しない場合はnilとなる
    min = distance&.to_f&.div(80)
    nearest_station = min ? "#{name}駅 徒歩#{min}分" : '未編集'

    build_office(lng: x&.to_f, lat: y&.to_f, nearest_station:)
  end

  private

  # 郵便番号から緯度経度を取得する
  def fetch_lat_lng(postal)
    res_lat_lng = search_by_postal(postal)['response']
    x = res_lat_lng.dig('location', 0, 'x')
    y = res_lat_lng.dig('location', 0, 'y')
    { x:, y: }
  end

  # 郵便番号から最寄り駅名と距離を取得する
  def fetch_station(postal)
    res_get_stations = get_stations(postal)['response']
    name = res_get_stations.dig('station', 0, 'name')
    distance = res_get_stations.dig('station', 0, 'distance')
    { name:, distance: }
  end
end
