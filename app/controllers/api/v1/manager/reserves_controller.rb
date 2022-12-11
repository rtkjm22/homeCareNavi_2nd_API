module Api
  module V1
    module Manager
      class ReservesController < ApplicationController
        before_action :authenticate_api_v1_manager!
      end
    end
  end
end


