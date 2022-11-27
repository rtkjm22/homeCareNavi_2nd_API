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
      login office.manager
      get api_v1_manager_office_clients_path
      response_symbolized_body => { office_clients: }
      expect(office_clients.length).to eq office_client_list.length
      assert_response_schema_confirm(200)
    end
  end
end
