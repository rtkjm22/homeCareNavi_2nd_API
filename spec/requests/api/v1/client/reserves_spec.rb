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
      get api_v1_client_reserves_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'マネージャーでログインした場合、エラーが返ってくること' do
      login manager

      get api_v1_client_reserves_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /api/v1/client/reserves' do
    let(:client) { create(:client) }
    let(:manager) { create(:manager) }

    it '自分の事業所の、スタッフを作成できること' do
      reserve = create(:reserve)
      login client
      reserve_params = { office_id: reserve.office_id,
                         interview_begin_at: reserve.interview_begin_at,
                         interview_end_at: reserve.interview_end_at,
                         user_name: reserve.user_name,
                         user_age: reserve.user_age,
                         contact_tel: reserve.contact_tel,
                         note: reserve.note
                       }
      expect { post api_v1_client_reserves_path, params: reserve_params }.to change(client.reserves, :count).by(1)
      expect(response).to have_http_status(:success)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      post api_v1_client_reserves_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'マネ―ジャーでログインした場合、エラーが返ってくること' do
      login manager
      post api_v1_client_reserves_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
