require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'バリデーション' do
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end

    context 'tel' do
      it { is_expected.to validate_presence_of(:tel) }
    end

    context 'postal' do
      it { is_expected.to validate_presence_of(:postal) }
      it { is_expected.to validate_length_of(:postal).is_equal_to(7) }
    end

    context 'address' do
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end

    # password及びemailはdeviseの:validatableでバリデーションしている
    # @see https://github.com/heartcombo/devise/blob/main/lib/devise/models/validatable.rb
    context 'password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_confirmation_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(128) }
    end

    context 'email' do
      let(:client) { build(:client) }

      it { is_expected.to validate_presence_of(:email) }

      it 'アドレスは一意であること' do
        create(:client, email: 'test@example.com')
        client.email = 'test@example.com'
        expect(client.valid?).to be false
        expect(client.errors.full_messages[0]).to match 'メールアドレスはすでに存在します'
      end

      it '有効なアドレスは検証に成功すること' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          client.email = valid_address
          expect(client).to be_valid, "#{valid_address.inspect} should be valid"
        end
      end

      it '無効なアドレスは検証に失敗すること' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |invalid_address|
          client.email = invalid_address
          expect(client).not_to be_valid, "#{invalid_address.inspect} should be invalid"
        end
      end

      it 'アドレスは小文字で保存されること' do
        mixed_case_email = 'Foo@ExAMPle.CoM'
        client.email = mixed_case_email
        client.save
        expect(client.reload.email).to eq mixed_case_email.downcase
      end
    end
  end
end
