require 'rails_helper'

RSpec.describe Office do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:manager) }
      it { is_expected.to have_one(:office_overview).dependent(:destroy) }
      it { is_expected.to have_many(:office_images).dependent(:destroy) }

      it do
        create(:office)
        expect(subject).to validate_uniqueness_of(:manager_id)
      end

      it '親を削除しないと、削除できないこと' do
        office = create(:office)
        office.destroy
        expect(office.errors.full_messages[0]).to eq 'このモデルのみを削除することはできません。削除する場合は、親を削除してください。'
      end

      it 'office_overviewが無効な属性値の場合、officeも無効であること' do
        office = build(:office)
        office_overview = build(:office_overview, office:)
        office_overview.room_count = -1
        expect(office.valid?).to be false
        expect(office.errors.full_messages[0]).to eq '施設概要は不正な値です'
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

  describe 'search_by_areaメソッド' do
    before do
      manager_tokyo1 = create(:manager, address: '東京都港区芝浦１丁目１−１')
      create(:office, manager: manager_tokyo1)

      manager_tokyo2 = create(:manager, address: '東京都新宿区西新宿１丁目１−１')
      create(:office, manager: manager_tokyo2)

      manager_ibaraki = create(:manager, address: '茨城県水戸市中央１丁目１−１')
      create(:office, manager: manager_ibaraki)
    end

    it '東京都で検索した場合、２件返ってくること' do
      search_result = Office.search_by_area(['東京都'])
      expect(search_result.count).to eq(2)
      expect(search_result.pluck(:address)).to be_all { |address| address.start_with?('東京都') }
    end

    it '東京都及び茨城県で検索した場合、３件返ってくること' do
      search_result = Office.search_by_area(%w[東京都 茨城県])
      expect(search_result.count).to eq(3)
    end

    it '東京都港区で検索した場合、１件返ってくること' do
      search_result = Office.search_by_area(['東京都港区'])
      expect(search_result.count).to eq(1)
      expect(search_result.pluck(:address)).to be_all { |address| address.start_with?('東京都港区') }
    end

    it '茨城県で検索した場合、１件返ってくること' do
      search_result = Office.search_by_area(['茨城県'])
      expect(search_result.count).to eq(1)
      expect(search_result.pluck(:address)).to be_all { |address| address.start_with?('茨城県') }
    end

    it 'いずれも一致しない文字列で検索した場合、０件返ってくること' do
      search_result = Office.search_by_area(['神奈川県'])
      expect(search_result.count).to eq(0)
    end
  end

  describe 'search_by_nearestメソッド' do
    let!(:office1) { create(:office, lat: 0.0, lng: 0.0) }
    let!(:office2) { create(:office, lat: 10.0, lng: 10.0) }
    let!(:office3) { create(:office, lat: 25.0, lng: 25.0) }
    let!(:office4) { create(:office, lat: 45.0, lng: 45.0) }
    let!(:office5) { create(:office, lat: 70.0, lng: 70.0) }

    it '現在地がoffice1の場合、office1から近い順に返ってくること' do
      expect(Office.search_by_nearest(0.0, 0.0)).to eq [office1, office2, office3, office4, office5]
    end

    it '現在地がoffice3の場合、office3から近い順に返ってくること' do
      expect(Office.search_by_nearest(25.0, 25.0)).to eq [office3, office2, office4, office1, office5]
    end

    it '現在地がoffice5の場合、office5から近い順に返ってくること' do
      expect(Office.search_by_nearest(70.0, 70.0)).to eq [office5, office4, office3, office2, office1]
    end
  end

  describe 'search_by_wordメソッド' do
    context 'manager.address' do
      let!(:office_tokyo_shibuya) do
        manager = create(:manager, address: '東京都渋谷区宇田川町1-1')
        create(:office, manager:)
      end

      let!(:office_tokyo_mitaka) do
        manager = create(:manager, address: '東京都三鷹市野崎1-1-10')
        create(:office, manager:)
      end

      it '"東京"で検索した場合、2件返ってくること' do
        result = Office.search_by_word('東京')
        expect(result.length).to eq 2
      end

      it '"東京 渋谷"で検索した場合、1件返ってくること（半角スペース）' do
        result = Office.search_by_word('東京 渋谷')
        expect(result.length).to eq 1
        expect(result[0]).to eq office_tokyo_shibuya
      end

      it '"東京　渋谷"で検索した場合、1件返ってくること（全角スペース）' do
        result = Office.search_by_word('東京　渋谷')
        expect(result.length).to eq 1
        expect(result[0]).to eq office_tokyo_shibuya
      end

      it '"三鷹"で検索した場合、１件返ってくること' do
        result = Office.search_by_word('三鷹')
        expect(result.length).to eq 1
        expect(result[0]).to eq office_tokyo_mitaka
      end

      it 'いずれも一致しない単語で検索した場合、0件返ってくること' do
        result = Office.search_by_word('茨城')
        expect(result.length).to eq 0
      end
    end

    context 'offices.name' do
      let!(:office_tokyo_sukkri) { create(:office, name: '東京すっきりホームケア') }
      let!(:office_tokyo_sawayaka) { create(:office, name: '東京さわやかホームケア') }

      it '"東京"で検索した場合、2件返ってくること' do
        result = Office.search_by_word('東京')
        expect(result.length).to eq 2
      end

      it '"東京 すっきり"で検索した場合、1件返ってくること' do
        result = Office.search_by_word('東京 すっきり')
        expect(result.length).to eq 1
        expect(result[0]).to eq office_tokyo_sukkri
      end

      it 'いずれも一致しない単語で検索した場合、0件返ってくること' do
        result = Office.search_by_word('ほんのり')
        expect(result.length).to eq 0
      end
    end
  end
end
