require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Staffs', type: :request do
  describe 'GET /api/v1/manager/staffs' do
    let!(:staff) { create(:staff) }
    let(:manager) { staff.office.manager }
    let(:client) { create(:client) }

      it '全てのスタッフを取得する' do
        FactoryBot.create_list(:staff, 10)
        login manager
        get api_v1_manager_staffs_path
        expect(response).to have_http_status(:success)
      end

      it 'ログインしていない場合、エラーが返ってくること' do
        get api_v1_manager_staffs_path
        expect(response).to have_http_status(:unauthorized)
      end

      it 'クライアントでログインした場合、エラーが返ってくること' do
        login client
        get api_v1_manager_staffs_path
        expect(response).to have_http_status(:unprocessable_entity)
      end
  end
end
