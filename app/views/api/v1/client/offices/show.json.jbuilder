office = {
  id: @office.id,
  name: @office.name,
  postal: @office.manager.postal,
  address: @office.manager.address,
  nearest_station: @office.nearest_station,
  staff_count: @office.staffs.size,
  tel: @office.manager.tel,
  fax: @office.fax,
  workday: @office.workday.to_a,
  workday_detail: @office.workday_detail,
  feature_title: @office.feature_title,
  feature_detail: @office.feature_detail,
  is_bookmark: false
}

carousel_images = @office.office_images.filter(&:carousel?)

feature_images = @office.office_images.filter(&:feature?)

staffs = @office.staffs.with_attached_avatar.map do |staff|
  staff_attrs = staff.attributes
  staff_attrs.merge(
    thanks_messages: %w[ダミーテキスト１ ダミーテキスト２], # TODO: thanksテーブル追加後機能修正
    avatar_url: staff.avatar_url
  )
end

office_overview = @office.office_overview

json.set! :office, office
json.set! :carousel_images, carousel_images
json.set! :feature_images, feature_images
json.set! :staffs, staffs
json.set! :office_overview, office_overview
