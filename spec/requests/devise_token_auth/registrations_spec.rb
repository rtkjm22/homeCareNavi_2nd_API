require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::Registrations', type: :request do
  describe 'ユーザー新規作成' do
    context 'クライアントの場合' do
      let(:client_params) do
        attributes_for(:client, confirm_success_url: 'test1@example.com')
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

    context 'ケアマネの場合' do
      let!(:manager_params) do
        attributes_for(:manager, confirm_success_url: 'test1@example.com')
      end

      it '有効な属性値の場合、OfficeとOfficeOverviewsも一緒に作成されること', vcr: true do
        expect(Manager.count).to eq(0)
        expect(Office.count).to eq(0)
        expect(OfficeOverview.count).to eq(0)
        expect(ActionMailer::Base.deliveries.count).to eq(0)

        post api_v1_user_registration_path, params: manager_params

        expect(Manager.count).to eq(1)
        expect(Office.count).to eq(1)
        expect(OfficeOverview.count).to eq(1)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        assert_response_schema_confirm(200)
      end

      it '無効な属性値の場合、新規登録及びメール送信されないこと', vcr: true do
        manager_params[:name] = nil

        post api_v1_user_registration_path, params: manager_params
        expect(Manager.count).to eq(0)
        expect(Office.count).to eq(0)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        assert_response_schema_confirm(422)
      end
    end
  end

  describe 'ユーザー更新' do
    let!(:client) { create(:client) }
    let!(:new_client) { attributes_for(:client) }

    it 'ログイン済みの場合、更新できること' do
      login client

      patch api_v1_user_registration_path,
            params: { current_password: client.password, password_confirmation: new_client[:password], **new_client }

      expect(response_symbolized_body[:data]).to include new_client.except(:password, :confirmed_at)

      client.reload

      expect(client.valid_password?(new_client[:password])).to be true
      assert_response_schema_confirm(200)
    end

    it 'ログイン済みでもcurrent_passwordが渡されなかった場合、更新できないこと' do
      login client

      expect do
        patch api_v1_user_registration_path, params: { password_confirmation: new_client[:password], **new_client }
      end.not_to change { client.reload.email }
      assert_response_schema_confirm(422)
    end

    it '未ログインの場合、更新できないこと' do
      expect do
        patch api_v1_user_registration_path,
              params: { current_password: client.password, password_confirmation: new_client[:password], **new_client }
      end.not_to change { client.reload.email }
      assert_response_schema_confirm(404)
    end
  end

  describe 'ユーザー削除' do
    let!(:client) { create(:client) }

    it 'ログイン済みの場合、自分自身を論理削除出来ること' do
      login client
      expect { delete api_v1_user_registration_path }.to change { client.reload.discarded? }.to(true)
      assert_response_schema_confirm(200)
    end

    it '未ログインの場合、自分自身を論理削除できないこと' do
      expect { delete api_v1_user_registration_path }.not_to change { client.reload.discarded? }
      assert_response_schema_confirm(404)
    end
  end
end
