require 'rails_helper'

RSpec.describe 'Api::V1::Manager::OfficeOverviews', type: :request do
  describe 'GET /api/v1/manager/office_overview' do
    let!(:office_overview) { create(:office_overview) }
    let(:manager) { office_overview.office.manager }
    let(:client) { create(:client) }

    it 'ケアマネでログインした場合、施設概要を取得できること' do
      login manager
      get api_v1_manager_office_overview_path
      assert_response_schema_confirm(200)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_office_overview_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client
      get api_v1_manager_office_overview_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /api/v1/manager/office_overview' do
    let!(:office_overview) { create(:office_overview) }
    let(:manager) { office_overview.office.manager }
    let(:client) { create(:client) }
    let(:new_params) do
      attrs = office_overview.attributes
      attrs[:classify] = '類型アップデート'
      attrs
    end
    let(:req) { patch api_v1_manager_office_overview_path, params: new_params }

    it 'ケアマネでログインした場合、施設概要を更新できること' do
      pp described_class
      login manager
      expect do
        patch api_v1_manager_office_overview_path, params: new_params
        office_overview.reload
      end.to change(office_overview, :classify).to('類型アップデート')
      assert_response_schema_confirm(200)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      patch api_v1_manager_office_overview_path, params: new_params
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client
      patch api_v1_manager_office_overview_path, params: new_params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it '無効な値の場合、エラーレスポンスが返ってくること' do
      new_params[:classify] = 'a' * 201
      login manager
      patch api_v1_manager_office_overview_path, params: new_params
      assert_response_schema_confirm(400)
    end
  end
end
