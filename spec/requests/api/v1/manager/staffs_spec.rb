require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Staffs' do
  describe 'GET /api/v1/manager/staffs' do
    let(:office) { create(:office) }
    let(:manager) { office.manager }
    let(:client) { create(:client) }

    it '自分の事業所の、全てのスタッフを取得できること' do
      create_list(:staff, 5, office:)
      create_list(:staff, 3)
      login manager
      get api_v1_manager_staffs_path
      expect(response.parsed_body.length).to eq 5
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
