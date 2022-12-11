module Api
  module V1
    module Manager
      class ReservesController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          reserves = current_api_v1_manager.office.reserves
          render json: reserves, status: :ok
        end
      end
    end
  end
end


