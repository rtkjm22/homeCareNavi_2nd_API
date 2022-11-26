# frozen_string_literal: true

module Api
  module V1
    module Manager
      class StaffsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          belong_staffs = current_api_v1_user.office.staffs
          render json: belong_staffs, status: :ok
        end
      end
    end
  end
end
