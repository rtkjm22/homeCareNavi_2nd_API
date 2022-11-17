require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::TokenValidations' do
  describe 'トークン検証' do
    let!(:client) { create(:client) }

    it 'ログイン済みの場合、検証に成功すること' do
      login client
      get api_v1_auth_validate_token_path
      response_symbolized_body[:data] => { id: }
      expect(id).to eq client.id
      assert_response_schema_confirm(200)
    end

    it '未ログインの場合、検証に失敗すること' do
      get api_v1_auth_validate_token_path
      response_symbolized_body => { success: }
      expect(success).to be false
      assert_response_schema_confirm(401)
    end
  end
end
