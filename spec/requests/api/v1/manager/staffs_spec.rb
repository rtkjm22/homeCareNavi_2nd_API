require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Staffs' do
  describe 'GET /api/v1/manager/staffs' do
    let(:office) { create(:office) } # create(:staff) → create(:office)
    let(:manager) { office.manager }
    let(:client) { create(:client) }

    it '自分の事業所の、全てのスタッフを取得できること' do
      # 自分の事業所のスタッフ。office: は office: officeと同義です。ruby3.1から追加されました。
      # https://bugs.ruby-lang.org/issues/14579
      create_list(:staff, 5, office:)
      create_list(:staff, 3) # 他の事業所のスタッフ
      login manager
      get api_v1_manager_staffs_path
      # response.parsed_bodyはレスポンスのjson部分のみを抽出してくれるメソッド
      # https://api.rubyonrails.org/classes/ActionDispatch/TestResponse.html#method-i-parsed_body
      expect(response.parsed_body.length).to eq 5 # 5人返ってきていれば（ほぼ）間違いなく自分の事業所スタッフ
      expect(response).to have_http_status(:success)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      get api_v1_manager_staffs_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client
      get api_v1_manager_staffs_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /api/v1/manager/staffs' do
    let(:office) { create(:office) }
    let(:manager) { office.manager }
    let(:client) { create(:client) }

    it '自分の事業所の、スタッフを作成できること' do
      staff = create(:staff)
      login manager
      staff_params = { name: staff.name,
                       furigana: staff.furigana,
                       introduction: staff.introduction,
                       role: 'care_manager' }
      expect { post api_v1_manager_staffs_path, params: staff_params }.to change(manager.office.staffs, :count).by(1)
      expect(response).to have_http_status(:success)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      post api_v1_manager_staffs_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client
      post api_v1_manager_staffs_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /api/v1/manager/staffs/:id' do
    let(:office) { create(:office) }
    let(:manager) { office.manager }
    let(:client) { create(:client) }

    before do
      @staff = create(:staff, office:)
    end

    it '属性値が有効なら自分の事業所の、スタッフを更新できること' do
      login office.manager
      staff_params = { name: 'new name',
                       furigana: 'new furigana',
                       introduction: 'new introduction',
                       role: 'worker' }

      patch api_v1_manager_staff_path(@staff), params: staff_params
      expect(response_symbolized_body).to include staff_params
      expect(response).to have_http_status(:success)
    end

    it '属性値が無効なら、エラーが返ってくること' do
      login office.manager
      staff_params = { name: nil }
      patch api_v1_manager_staff_path(@staff), params: staff_params
      expect(response).to have_http_status(:bad_request)
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      patch api_v1_manager_staff_path(@staff)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      login client
      patch api_v1_manager_staff_path(@staff)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
