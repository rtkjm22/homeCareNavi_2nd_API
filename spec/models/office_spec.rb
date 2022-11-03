require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:manager) }
      it { is_expected.to have_one(:office_overview).dependent(:destroy) }

      it do
        create(:office)
        expect(subject).to validate_uniqueness_of(:manager_id)
      end

      it '親を削除しないと、削除できないこと' do
        office = create(:office)
        office.destroy
        expect(office.errors.full_messages[0]).to eq 'このモデルのみを削除することはできません。削除する場合は、親を削除してください。'
      end
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(200) }
    end

    context 'feature_title' do
      it { is_expected.to validate_presence_of(:feature_title) }
      it { is_expected.to validate_length_of(:feature_title).is_at_most(200) }
    end

    context 'feature_detail' do
      it { is_expected.to validate_presence_of(:feature_detail) }
    end

    context 'workday_detail' do
      it { is_expected.to validate_presence_of(:workday_detail) }
    end

    context 'lat' do
      it { is_expected.to validate_numericality_of(:lat) }
    end

    context 'lng' do
      it { is_expected.to validate_numericality_of(:lng) }
    end

    context 'fax' do
      it { is_expected.to validate_presence_of(:fax) }
    end

    context 'nearest_station' do
      it { is_expected.to validate_presence_of(:nearest_station) }
    end
  end
end
