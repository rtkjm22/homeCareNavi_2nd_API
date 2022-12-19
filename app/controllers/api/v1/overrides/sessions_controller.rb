# frozen_string_literal: true

module Api
  module V1
    module Overrides
      class SessionsController < DeviseTokenAuth::SessionsController
        # ログイン時に異なるユーザータイプのアカウントだった場合弾く
        def create
          super do
            if @resource.type != params[:type]
              user = remove_instance_variable(:@resource)
              client = @token.client
              @token.clear!
              user.tokens.delete(client)
              user.save!
              return render_create_error_bad_credentials
            end
          end
        end
      end
    end
  end
end
