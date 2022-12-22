module Api
  module V1
    module Client
      class ReservesController < ApplicationController
        before_action :authenticate_api_v1_client!
        def index
          my_reserves = current_api_v1_client.reserves
          render json: my_reserves, status: :ok
        end

        def create
          reserve = current_api_v1_client.reserves.build(reserve_params)
          if reserve.save
            render json: reserve, status: :ok
          else
            render json: reserve.as_error_json, status: :bad_request
          end
        end

        private

        def reserve_params
          params.permit(:office_id, :interview_begin_at, :interview_end_at, :user_name, :user_age, :contact_tel, :note)
        end
      end
    end
  end
end
