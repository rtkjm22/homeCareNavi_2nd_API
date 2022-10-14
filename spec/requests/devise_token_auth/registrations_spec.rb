require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::Registrations', type: :request do
  describe 'ユーザー新規作成' do
    let(:client_params) do
      client_attr = attributes_for(:client)
      client_attr.merge(confirm_success_url: 'test1@example.com')
    end

    it '有効な属性値の場合、新規登録及びメール送信されること' do
      expect(Client.count).to eq(0)
      expect(ActionMailer::Base.deliveries.count).to eq(0)

      post api_v1_user_registration_path, params: client_params

      expect(Client.count).to eq(1)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      assert_response_schema_confirm(200)
    end

    it '無効な属性値の場合、新規登録及びメール送信されないこと' do
      client_params[:name] = nil

      post api_v1_user_registration_path, params: client_params
      expect(Client.count).to eq(0)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      assert_response_schema_confirm(422)
    end
  end

  describe 'ユーザー更新' do
    let!(:client) { create(:client) }
    let!(:new_email) { 'new@example.com' }
    let!(:new_password) { 'new-password' }

    it 'ログイン済みの場合、更新できること' do
      login client

      patch api_v1_user_registration_path,
            params: { email: new_email, password: new_password, current_password: client.password }

      client.reload

      expect(client.email).to eq new_email
      expect(client.valid_password?(new_password)).to be true
      assert_response_schema_confirm(200)
    end

    it 'ログイン済みでもcurrent_passwordが渡されなかった場合、更新できないこと' do
      login client

      expect do
        patch api_v1_user_registration_path, params: { email: new_email, password: new_password }
      end.not_to change { client.reload.email }
      assert_response_schema_confirm(422)
    end

    it '未ログインの場合、更新できないこと' do
      expect do
        patch api_v1_user_registration_path, params: { email: new_email, current_password: client.password }
      end.not_to change { client.reload.email }
      assert_response_schema_confirm(404)
    end
  end

  describe 'ユーザー削除' do
    let!(:client) { create(:client) }

    it 'ログイン済みの場合、自分自身を削除出来ること' do
      login client
      expect { delete api_v1_user_registration_path }.to change(Client, :count).by(-1)
      assert_response_schema_confirm(200)
    end

    it '未ログインの場合、自分自身を削除できないこと' do
      expect { delete api_v1_user_registration_path }.not_to change(Client, :count)
      assert_response_schema_confirm(404)
    end
  end
end
