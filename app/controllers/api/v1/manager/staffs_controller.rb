# frozen_string_literal: true

module Api
  module V1
    module Manager
      class StaffsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          staffs = current_api_v1_user.office.staffs
          render json: staffs, status: :ok
        end

        def create
          office = current_api_v1_manager.office
          staff = office.staffs.build(staff_params)
          if staff.save
            render json: staff, status: :ok
          else
            render json: staff.as_error_json, status: :bad_request
          end
        end

        def update
          staffs = current_api_v1_manager.office.staffs
          staff = staffs.find(params[:id])
          if staff.update(staff_params)
            render json: staff, status: :ok
          else
            render json: staff.as_error_json, status: :bad_request
          end
        end

        def destroy
          staffs = current_api_v1_manager.office.staffs
          staff = staffs.find(params[:id])
          if staff.destroy
            render body: nil, status: :no_content
          else
            render json: staff.as_error_json, status: :bad_request
          end
        end

        private

        def staff_params
          params.permit(:name, :furigana, :introduction, :role)
        end
      end
    end
  end
end
