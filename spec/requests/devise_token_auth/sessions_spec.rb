require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::Sessions' do
  describe 'ログイン' do
    let!(:client) { create(:client) }

    context 'メールアドレス及びパスワードが有効な場合' do
      let!(:params) { { email: client.email, password: client.password, type: 'Client' } }

      it 'ユーザー情報及びトークンが返ってくること' do
        post new_api_v1_user_session_path, params: params
        response_symbolized_body[:data] => { id: }
        expect(id).to eq client.id
        expect(response.has_header?('access-token')).to be true
        assert_response_schema_confirm(200)
      end

      it 'ユーザーが論理削除されている場合、エラーレスポンスが返ってくること' do
        client.discard
        expect(client.discarded?).to be true
        post new_api_v1_user_session_path, params: params
        response_symbolized_body => { success: }
        expect(success).to be false
        assert_response_schema_confirm(401)
      end

      it 'typeが異なる場合、エラーレスポンスが返ってくること' do
        params[:type] = 'Manager'
        post new_api_v1_user_session_path, params: params
        response_symbolized_body => { success: }
        expect(success).to be false
        expect(client.reload.tokens).to be_empty
        assert_response_schema_confirm(401)
      end
    end

    it 'メールアドレス及びパスワードが無効な場合、エラーレスポンスが帰ってくること' do
      post new_api_v1_user_session_path, params: { email: 'invalid-email@com', password: 'invalid-password' }
      response_symbolized_body => { success: }
      expect(success).to be false
      assert_response_schema_confirm(401)
    end
  end

  describe 'ログアウト' do
    let!(:client) { create(:client) }

    it 'ログイン状態の場合、ログアウト出来ること' do
      login client
      delete destroy_api_v1_user_session_path
      response_symbolized_body => { success: }
      expect(success).to be true
      assert_response_schema_confirm(200)
    end

    it '未ログインの場合、ログアウト出来ないこと' do
      delete destroy_api_v1_user_session_path
      response_symbolized_body => { success: }
      expect(success).to be false
    end
  end
end
