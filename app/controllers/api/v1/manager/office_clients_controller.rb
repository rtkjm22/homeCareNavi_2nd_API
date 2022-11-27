module Api
  module V1
    module Manager
      class OfficeClientsController < ApplicationController
        before_action :authenticate_api_v1_manager!

        def index
          @staffs = current_api_v1_manager.office.staffs
          @office_clients = OfficeClient.where(staff_id: @staffs.ids).with_attached_avatar
        end
      end
    end
  end
end
