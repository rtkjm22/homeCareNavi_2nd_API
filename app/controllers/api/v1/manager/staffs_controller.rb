class Api::V1::Manager::StaffsController < ApplicationController
  before_action :authenticate_api_v1_manager!

  def index
    staffs = Staff.where(office_id: current_api_v1_user.office.id)
  end

  def create
  end

  def destroy
  end

  def update
  end
end
