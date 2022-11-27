require 'rails_helper'

RSpec.describe 'Api::V1::Manager::OfficeClients' do
  describe 'before_action :authenticate_api_v1_manager!' do
    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_office_clients_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      client = create(:client)
      login client
      get api_v1_manager_office_clients_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/v1/manager/office_clients' do
    let!(:office) { create(:office) }
    let!(:staff) { create(:staff, office:) }
    let!(:office_client_list) { create_list(:office_client, 3, :with_avatar, staff:) }

    it '自分の事業所のクライアント一覧を取得できること' do
      create_list(:office_client, 2)  # 他の事業所のクライアントを閲覧できないことを確認する
      login office.manager
      get api_v1_manager_office_clients_path
      response_symbolized_body => { office_clients: }
      expect(office_clients.pluck(:id)).to eq office_client_list.pluck(:id)
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /api/v1/manager/office_client/:id' do
    let!(:office) { create(:office) }
    let!(:staff_list) { create_list(:staff, 5, office:) }
    let!(:office_client) { create(:office_client, staff_id: staff_list[0]['id']) }

    it '自分の事業所のクライアント詳細を取得できること' do
      login office.manager
      get api_v1_manager_office_client_path(office_client.id)
      response_symbolized_body => { id:, staffs: }
      expect(id).to eq office_client.id
      expect(staffs.length).to eq 5
      assert_response_schema_confirm(200)
    end

    it '他の事業所のクライアントは取得できないこと' do
      another_office_client = create(:office_client)
      login office.manager
      expect do
        get api_v1_manager_office_client_path(another_office_client.id)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
