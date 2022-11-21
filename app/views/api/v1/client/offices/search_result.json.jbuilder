offices = @result.map do |office|
  {
    id: office.id,
    name: office.name,
    nearest_station: office.nearest_station,
    stuff_count: 10, # TODO: スタッフの人数は後から追加
    is_bookmark: false, # TODO: 余裕があればブックマーク機能追加
    tel: office.manager.tel,
    feature_title: office.feature_title,
    workday: office.workday,
    thumbnail_image: office.office_images.find(&:thumbnail?)&.image_url
  }
end

json.set! :offices, offices
json.partial! 'api/v1/shared/paginate'
