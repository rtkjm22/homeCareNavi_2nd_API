# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ApplicationController
      private

      # 未ログインまたはクライアントではない場合、エラーレンダリングする
      def authenticate_api_v1_client!
        return if authenticate_api_v1_user!

        render_user_type_mismatch unless current_api_v1_user.client?
      end

      # 未ログインまたはケアマネではない場合、エラーレンダリングする
      def authenticate_api_v1_manager!
        return if authenticate_api_v1_user!

        render_user_type_mismatch unless current_api_v1_user.manager?
      end

      def render_user_type_mismatch
        json = {
          status: 'error',
          errors: {
            full_messages: [
              '実行に必要なアクセス権がありませんでした。'
            ]
          }
        }

        render json:, status: :unprocessable_entity
      end

      alias current_api_v1_manager current_api_v1_user
      alias current_api_v1_client current_api_v1_user
    end
  end
end
