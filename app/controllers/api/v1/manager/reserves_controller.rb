module Api
  module V1
    module Manager
      class ReservesController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          reserves = current_api_v1_manager.office.reserves
          render json: reserves, status: :ok
        end

        def update
          reserves = current_api_v1_manager.office.reserves
          reserve_to_update = reserves.find(params[:id])

          if reserve_to_update.update!(is_contacted: true)
            render json: reserve_to_update, status: :ok
          else
            render json: reserve_to_update.as_error_json, status: :bad_request
          end
        end

      end
    end
  end
end


