require 'rails_helper'

RSpec.describe 'Api::V1::Client::Offices' do
  describe 'GET /api/v1/client/offices/area' do
    context 'クライアントでログインした場合' do
      before do
        # ページネーションは10件単位なので、11件作成し2ページの挙動をテストできるようにする
        create_list(:office_image, 11)
        staffs = Office.ids.map { |office_id| attributes_for(:staff, office_id:) }
        Staff.insert_all(staffs)
        Manager.update_all(address: '北海道札幌市北区北十条西3-23-1')
      end

      let!(:client) { create(:client) }

      it 'クエリパラメータにpageが存在しない場合、1ページ目かつ10件の事業所が返ってくること' do
        login client
        get area_search_api_v1_client_offices_path, params: { q: '北海道札幌市北区' }
        response_symbolized_body => { offices:, paginate: }
        expect(paginate[:current_page]).to eq 1
        expect(offices.length).to eq 10
        assert_response_schema_confirm(200)
      end

      it 'クエリパラメータのpageに2を指定した場合、2ページ目かつ1件の事業所が返ってくること' do
        login client
        get area_search_api_v1_client_offices_path, params: { q: '北海道札幌市北区', page: 2 }
        response_symbolized_body => { offices:, paginate: }
        expect(paginate[:current_page]).to eq 2
        expect(offices.length).to eq 1
        assert_response_schema_confirm(200)
      end
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get area_search_api_v1_client_offices_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'ケアマネでログインした場合、エラーが返ってくること' do
      manager = create(:manager)
      login manager
      get area_search_api_v1_client_offices_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
