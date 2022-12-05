require 'rails_helper'

RSpec.describe 'Api::V1::Client::Offices' do
  describe 'GET /api/v1/client/offices/:id' do
    include_context 'setup_office'

    it '事業所詳細を取得できること' do
      get api_v1_client_office_path(office.id)
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /api/v1/client/offices/area_search' do
    before do
      # ページネーションは10件単位なので、11件作成し2ページの挙動をテストできるようにする
      create_list(:office, 11)
      staffs = Office.ids.map { |office_id| attributes_for(:staff, office_id:) }
      Staff.insert_all(staffs)
      Manager.update_all(address: '北海道札幌市北区北十条西3-23-1')
    end

    let!(:client) { create(:client) }

    it 'クエリパラメータにpageが存在しない場合、1ページ目かつ10件の事業所が返ってくること' do
      login client
      get area_search_api_v1_client_offices_path, params: { areas: '北海道札幌市北区' }
      response_symbolized_body => { offices:, paginate: }
      expect(paginate[:current_page]).to eq 1
      expect(offices.length).to eq 10
      assert_response_schema_confirm(200)
    end

    it 'クエリパラメータのpageに2を指定した場合、2ページ目かつ1件の事業所が返ってくること' do
      login client
      get area_search_api_v1_client_offices_path, params: { areas: '北海道札幌市北区', page: 2 }
      response_symbolized_body => { offices:, paginate: }
      expect(paginate[:current_page]).to eq 2
      expect(offices.length).to eq 1
      assert_response_schema_confirm(200)
    end

    it 'クエリパラメータをカンマ区切りで指定した場合、複数検索できること' do
      Manager.first.update!(address: '東京都新宿区市谷本村町5-1')
      Manager.second.update!(address: '広島県福山市南蔵王町4-1-7')
      Manager.third.update!(address: '千葉県浦安市富士見1-2-303')
      login client
      get area_search_api_v1_client_offices_path, params: { areas: '東京都新宿区市谷本村町,広島県福山市南蔵王町,千葉県浦安市富士見' }
      expect(response.parsed_body['offices'].length).to eq 3
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /api/v1/client/offices/nearest_search' do
    let!(:office_list) { create_list(:office, 3) }
    let!(:client) { create(:client) }

    it '事業所一覧が返ってくること' do
      login client
      get nearest_search_api_v1_client_offices_path, params: { lat: 0.0, lng: 0.0 }
      response_symbolized_body => { offices:, paginate: }
      expect(paginate[:current_page]).to eq 1
      expect(offices.length).to eq 3
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /api/v1/client/offices/word_search' do
    let!(:office_list) { create_list(:office, 3) }
    let!(:client) { create(:client) }

    it '事業所一覧が返ってくること' do
      login client
      get word_search_api_v1_client_offices_path, params: { words: 'ホームケア' }
      response_symbolized_body => { offices:, paginate: }
      expect(paginate[:current_page]).to eq 1
      expect(offices.length).to eq 3
      assert_response_schema_confirm(200)
    end
  end
end
