# frozen_string_literal: true
module Api
  module V1
    module Concerns
      # ActiveRecord::RecordNotFound等の汎用的なエラーレスポンスが定義されているモジュール
      # @see https://tech.pepabo.com/2021/03/15/rails-api-error-response/
      module ErrorRenderable
        extend ActiveSupport::Concern

        included do
          rescue_from ActiveRecord::RecordNotFound do
            render json: { errors: ['レコードが見つかりません'] }, status: :not_found
          end
        end
      end
    end
  end
end
