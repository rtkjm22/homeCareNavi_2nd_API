module Api
  module V1
    module Manager
      class OfficeClientsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          @staffs = current_api_v1_manager.office.staffs
          @office_clients = OfficeClient.where(staff_id: @staffs.ids).with_attached_avatar
        end

        def show
          @staffs = current_api_v1_manager.office.staffs
          @office_client = OfficeClient.where(staff_id: @staffs.ids).find(params[:id])
        end

        def create
          staff = current_api_v1_manager.office.staffs.find(params[:staff_id])
          office_client = staff.office_clients.build(office_client_params)
          if office_client.save
            render json: office_client, status: :ok
          else
            render json: office_client.as_error_json, status: :bad_request
          end
        end

        def update
          staffs = current_api_v1_manager.office.staffs
          office_client = OfficeClient.where(staff_id: staffs.ids).find(params[:id])
          if office_client.update(office_client_params)
            render json: office_client, status: :ok
          else
            render json: office_client.as_error_json, status: :bad_request
          end
        end

        private

        def office_client_params
          params.permit(:name, :furigana, :postal, :address, :family, :age, :avatar, :staff_id)
        end
      end
    end
  end
end
