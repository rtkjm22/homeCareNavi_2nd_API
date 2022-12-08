require 'rails_helper'

RSpec.describe "Api::V1::Client::Reserves", type: :request do
  describe "GET /api/v1/client/reserves" do
    let(:client) { create(:client) }
    let(:manager) { create(:manager) }

    it "事業所利用者が、自身の予約一覧を取得できること" do
      create_list(:reserve, 5, client:)
      create_list(:reserve, 3)

      login client

      get api_v1_client_reserves_path
      expect(response.parsed_body.length).to eq 5
      expect(response).to have_http_status(:success)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_reserves_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'マネージャーでログインした場合、エラーが返ってくること' do
      login manager

      get api_v1_manager_reserves_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
