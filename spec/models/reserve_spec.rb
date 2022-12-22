require 'rails_helper'

RSpec.describe Reserve do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:office) }
      it { is_expected.to belong_to(:client) }
    end

    context 'interview_begin_at' do
      it { is_expected.to validate_presence_of(:interview_begin_at) }
    end

    context 'interview_end_at' do
      it { is_expected.to validate_presence_of(:interview_end_at) }
    end

    context 'user_name' do
      it { is_expected.to validate_presence_of(:user_name) }
    end

    context 'user_age' do
      it { is_expected.to validate_presence_of(:user_age) }
    end

    context 'contact_tel' do
      it { is_expected.to validate_presence_of(:contact_tel) }
    end

    context 'is_contacted' do
      it { is_expected.to allow_value(true).for(:is_contacted) }
      it { is_expected.to allow_value(false).for(:is_contacted) }
      it { is_expected.not_to allow_value(nil).for(:is_contacted) }
    end
  end
end
