office_images = @office.office_images

# office_images.thumbnail でもサムネイル画像を取得できるが、SQLが発行されてしまうため通常のRubyメソッドを使用している
thumbnail_image = office_images.find(&:thumbnail?)
feature_images = office_images.filter(&:feature?)
carousel_images = office_images.filter(&:carousel?)

json.merge! @office.attributes
# workday: [1] のような形式から workday: [:sun] の形式に上書き
json.set! :workday, @office.workday.to_a
json.set! :thumbnail_image, thumbnail_image
json.set! :feature_images, feature_images
json.set! :carousel_images, carousel_images
