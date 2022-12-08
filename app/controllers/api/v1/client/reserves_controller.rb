module Api
  module V1
    module Client
      class ReservesController < ApplicationController
        before_action :authenticate_api_v1_client!
        def index
          my_reserves = current_api_v1_client.reserves

          render json: my_reserves, status: :ok
        end
      end
    end
  end
end
