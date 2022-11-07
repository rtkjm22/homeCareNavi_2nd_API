require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Offices', type: :request do
  describe 'GET /api/v1/manager/office' do
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

  describe 'PATCH /api/v1/manager/office' do
    context 'ケアマネでログインした場合' do
      let!(:office) { create(:office) }

      it '属性値が有効なら、事業所を更新できること' do
        login office.manager
        office_params = { name: 'new name',
                          feature_title: 'new title',
                          feature_detail: 'new detail',
                          workday: %w[sun sat],
                          workday_detail: 'new workday_detail',
                          fax: 'new fax' }
        patch api_v1_manager_office_path, params: office_params
        expect(response_symbolized_body).to include office_params
        assert_response_schema_confirm(200)
      end

      it '属性値が無効なら、エラーが返ってくること' do
        login office.manager
        office_params = { name: nil }
        patch api_v1_manager_office_path, params: office_params
        assert_response_schema_confirm(400)
      end
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      patch api_v1_manager_office_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      client = create(:client)
      login client
      patch api_v1_manager_office_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
