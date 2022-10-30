# frozen_string_literal: true

module Api
  module V1
    module Overrides
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        # 論理削除するためdevise_token_authのdestroyアクションを上書き
        # @see https://github.com/lynndylanhurley/devise_token_auth/blob/master/app/controllers/devise_token_auth/registrations_controller.rb#L81
        def destroy
          if @resource
            # @resource.destroy => @resource.discard に変更
            @resource.discard
            yield @resource if block_given?
            render_destroy_success
          else
            render_destroy_error
          end
        end

        protected

        def build_resource
          super
          # User.typeがManagerの場合、Officeも同時に作成する
          @resource.build_office_with_location if @resource&.manager?
        end
      end
    end
  end
end
