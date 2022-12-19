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

  describe "POST /api/v1/manager/reserve/:id" do
    let(:office) { create(:office) }
    let(:manager) { office.manager }
    let(:client) { create(:client) }
    let(:reserve) { office.reserve }
    let!(:update_params) do
      attrs = reserve.attributes
      attrs['is_contacted'] = true
      attrs
    end

    it "事業所は、自身の事業所のの予約を更新できる" do
      login manager
      expect do
        patch api_v1_manager_reserve_path(reserve),
              params: update_params,
              headers: { ContentType: 'multipart/form-data' }
        reserve.reload
      end.to change(reserve, :is_contacted).to(true)
    end

    it '事業所は、他の事業所の予約を更新ができない' do
      another_reserve = create(:reserve)
      update_params = another_reserve.attributes
      update_params['is_contacted'] = true
      login manager
      expect do
        patch api_v1_manager_reserve_path(another_reserve),
              params: update_params,
              headers: { ContentType: 'multipart/form-data' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end
