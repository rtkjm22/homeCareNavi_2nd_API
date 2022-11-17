require 'rails_helper'

RSpec.describe Manager do
  describe 'バリデーション' do
    it { is_expected.to have_one(:office).dependent(:destroy) }
  end

  describe 'build_office_with_locationメソッド' do
    let(:manager) { build(:manager) }

    it '有効な郵便番号の場合、オフィスに経度緯度及び最寄り駅の情報が存在すること', vcr: true do
      office = manager.build_office_with_location
      expect(office.lat).not_to be_nil
      expect(office.lng).not_to be_nil
      expect(office.nearest_station).not_to be_nil
    end

    it '無効な郵便番号の場合、オフィスの経度緯度及び最寄り駅が初期値であること', vcr: true do
      manager.postal = '1628804'  # 無効な郵便番号
      office = manager.build_office_with_location
      expect(office.lat).to be_nil
      expect(office.lng).to be_nil
      expect(office.nearest_station).to eq '未編集'
    end
  end
end
