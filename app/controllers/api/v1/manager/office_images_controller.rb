module Api
  module V1
    module Manager
      class OfficeImagesController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def create
          office_images = current_api_v1_manager.office.office_images
          office_image = office_images.build(office_image_params)
          if office_image.save
            render json: office_image, status: :ok
          else
            render json: office_image.as_error_json, status: :bad_request
          end
        end

        def update
          office_images = current_api_v1_manager.office.office_images
          office_image = office_images.find(params[:id])
          if office_image.update(office_image_params)
            render json: office_image, status: :ok
          else
            render json: office_image.as_error_json, status: :bad_request
          end
        end

        private

        def office_image_params
          params.permit(:image, :caption, :role)
        end
      end
    end
  end
end
