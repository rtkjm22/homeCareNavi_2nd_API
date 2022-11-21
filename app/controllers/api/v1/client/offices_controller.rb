module Api
  module V1
    module Client
      class OfficesController < ApplicationController
        before_action :authenticate_api_v1_client!

        def area_search
          @result = Office.search_by_area(params[:q]).page(params[:page])
          render template: 'api/v1/client/offices/search_result', status: :ok
        end
      end
    end
  end
end