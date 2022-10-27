require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'バリデーション' do
    context 'manager_id' do
      it { is_expected.to belong_to(:manager) }

      it do
        create(:office)
        expect(subject).to validate_uniqueness_of(:manager_id)
      end
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(100) }
    end

    context 'feature_title' do
      it { is_expected.to validate_presence_of(:feature_title) }
      it { is_expected.to validate_length_of(:feature_title).is_at_most(100) }
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
