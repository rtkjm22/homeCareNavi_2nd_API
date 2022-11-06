module Api
  module V1
    module Manager
      class OfficesController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def show
          office = current_api_v1_manager.office
          office_images = office.office_images

          # office_images.thumbnail でもサムネイル画像を取得できるが、SQLが発行されてしまうため通常のRubyメソッドを使用している
          thumbnail_image = office_images.find(&:thumbnail?)
          feature_images = office_images.filter(&:feature?)
          carousel_images = office_images.filter(&:carousel?)

          # workday: [1] のような形式から workday: [:sun] の形式に変換
          attrs = office.attributes.merge(workday: office.workday.to_a)
          res = attrs.merge(thumbnail_image:, feature_images:, carousel_images:)
          render json: res, status: :ok
        end
      end
    end
  end
end
