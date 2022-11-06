require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Offices', type: :request do
  describe 'GET /index' do
    include_context 'setup_office'

    it 'ケアマネでログインした場合、事業所詳細が返ってくること' do
      login manager
      get api_v1_manager_office_path
      assert_response_schema_confirm(200)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_office_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      client = create(:client)
      login client
      get api_v1_manager_office_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
