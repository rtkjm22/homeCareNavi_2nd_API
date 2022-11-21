module Api
  module V1
    module Manager
      class OfficesController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def show
          @office = current_api_v1_manager.office
        end

        def update
          office = current_api_v1_manager.office
          if office.update(office_params)
            render json: office, status: :ok
          else
            render json: office.as_error_json, status: :bad_request
          end
        end

        private

        def office_params
          params.permit(:name, :feature_title, :feature_detail, :workday_detail, :fax, workday: [])
        end
      end
    end
  end
end
