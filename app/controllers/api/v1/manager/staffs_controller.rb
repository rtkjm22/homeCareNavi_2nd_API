# frozen_string_literal: true

module Api
  module V1
    module Manager
      class StaffsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          belong_office_id = current_api_v1_user.office.id
          staffs = Staff.where(office_id: belong_office_id)
          render json: staffs, status: :ok
        end

      end
    end
  end
end
