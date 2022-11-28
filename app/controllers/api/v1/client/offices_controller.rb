module Api
  module V1
    module Client
      class OfficesController < ApplicationController
        def area_search
          @result = Office.search_by_area(params[:q]).page(params[:page])
          render template: 'api/v1/client/offices/search_result', status: :ok
        end

        def nearest_search
          @result = Office.search_by_nearest(params[:lat], params[:lng]).page(params[:page])
          render template: 'api/v1/client/offices/search_result', status: :ok
        end

        def word_search
          @result = Office.search_by_word(params[:q]).page(params[:page])
          render template: 'api/v1/client/offices/search_result', status: :ok
        end
      end
    end
  end
end
