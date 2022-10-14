require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::Password', type: :request do
  let!(:client) { create(:client) }

  describe 'パスワード再設定メール送信' do
    it 'emailと一致するユーザーが存在する場合、パスワード再設定メールが送信されること' do
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      expect(client.reset_password_sent_at).to be_nil
      expect(client.reset_password_token).to be_nil

      post api_v1_user_password_path, params: { email: client.email }

      client.reload

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(client.reset_password_sent_at).not_to be_nil
      expect(client.reset_password_token).not_to be_nil
      assert_response_schema_confirm(200)
    end

    it 'emailと一致するユーザーが存在しない場合、エラーメッセージが返ってくること' do
      post api_v1_user_password_path, params: { email: 'invalid@example.com' }
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      expect(client.reset_password_sent_at).to be_nil
      expect(client.reset_password_token).to be_nil
      assert_response_schema_confirm(404)
    end
  end

  # このurlはフロントエンドから直接叩かないため、openapiに記載していない
  describe 'パスワード再設定トークン生成' do
    let!(:client) { create(:client) }

    it 'クエリパラメータにreset_password_tokenが含まれている場合、パスワード編集ページにリダイレクトされること' do
      post api_v1_user_password_path, params: { email: client.email }

      mail_body = ActionMailer::Base.deliveries.last.body.encoded
      reset_password_token = /reset_password_token=(.+)"/.match(mail_body)[1]

      expect do
        get edit_api_v1_user_password_path, params: { reset_password_token: }
      end.to change { client.reload.allow_password_change }.to(true)

      expect(response).to have_http_status(:found)
      expect(response.parsed_body).to match('http://localhost:8080/password-reset/edit')
    end
  end

  describe 'パスワード再設定' do
    let!(:client_user) { create(:client) }
    let(:new_password) { 'new_password' }

    # パスワードリセット要求〜メールクリックまで
    before do
      post api_v1_user_password_path, params: { email: client_user.email }

      mail_body = ActionMailer::Base.deliveries.last.body.encoded
      reset_password_token = /reset_password_token=(.+)"/.match(mail_body)[1]

      get edit_api_v1_user_password_path, params: { reset_password_token: }

      url = /href="(.+)"/.match(response.parsed_body)[1]

      @query_params = URI.decode_www_form(url).to_h do |param|
        param[0].gsub!(/amp;/, '')
        param
      end.symbolize_keys
    end

    context '認証ヘッダーが設定されている場合' do
      before do
        @query_params => { client:, token:, uid: }
        patch api_v1_user_password_path,
              params: { password: new_password, password_confirmation: new_password },
              headers: { client:, 'access-token': token, uid:, accept: 'application/json' }
        client_user.reload
        assert_response_schema_confirm(200)
      end

      it 'パスワードが再設定されること' do
        response_symbolized_body => { success: }
        expect(success).to be true
        expect(client_user.valid_password?(new_password)).to be true
      end

      it 'パスワード再設定に関わるカラムがnil及びfalseになること' do
        expect(client_user.reset_password_token).to be_nil
        expect(client_user.reset_password_sent_at).to be_nil
        expect(client_user.allow_password_change).to be false
      end
    end

    it '認証ヘッダーが設定されていない場合、エラーが返ってくること' do
      patch api_v1_user_password_path,
            params: { password: new_password, password_confirmation: new_password }
      response_symbolized_body => { success: }
      expect(success).to be false
      assert_response_schema_confirm(401)
    end
  end
end
