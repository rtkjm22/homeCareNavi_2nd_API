require 'rails_helper'

RSpec.describe "Api::V1::Manager::Reserves" do
  describe "GET /api/v1/manager/reserves" do
    let(:office) { create(:office) }
    let(:manager) { office.manager }
    let(:client) { create(:client) }

    it "事業所が、自身の予約一覧を取得できること" do
      create_list(:reserve, 5, office:)
      create_list(:reserve, 3)

      login manager

      get api_v1_manager_reserves_path
      expect(response.parsed_body.length).to eq 5
      expect(response).to have_http_status(:success)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_reserves_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client

      get api_v1_manager_reserves_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
