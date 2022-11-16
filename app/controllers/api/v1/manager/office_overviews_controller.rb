# frozen_string_literal: true

module Api
  module V1
    module Manager
      class OfficeOverviewsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def show
          office_overview = current_api_v1_manager.office.office_overview
          render json: office_overview, status: :ok
        end

        def update
          office_overview = current_api_v1_manager.office.office_overview
          if office_overview.update(office_overview_params)
            render json: office_overview, status: :ok
          else
            render json: office_overview.as_error_json, status: :bad_request
          end
        end

        private

        def office_overview_params
          params.permit(:classify, :opening_date, :room_count, :requirements, :shared_facilities, :business_entity,
                        :official_site_url)
        end
      end
    end
  end
end
