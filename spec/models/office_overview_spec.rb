require 'rails_helper'

RSpec.describe OfficeOverview do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:office) }

      it do
        create(:office_overview)
        expect(subject).to validate_uniqueness_of(:office_id)
      end

      it '親を削除しないと、削除できないこと' do
        office_overview = create(:office_overview)
        office_overview.destroy
        expect(office_overview.errors.full_messages[0]).to eq 'このモデルのみを削除することはできません。削除する場合は、親を削除してください。'
      end
    end

    context 'official_site_url' do
      let(:office_overview) { build(:office_overview) }

      it 'フォーマットがURLの場合、有効であること' do
        office_overview.official_site_url = 'https://www.unimat-rc.co.jp/shisetsu/sosigaya_871/index.html'
        expect(office_overview.valid?).to be true
      end

      it 'フォーマットがURLではない場合、無効であること' do
        office_overview.official_site_url = 'hoge'
        expect(office_overview.valid?).to be false
      end

      it 'nilの場合は有効であること' do
        office_overview.official_site_url = nil
        expect(office_overview).to be_valid
      end
    end

    context 'room_count' do
      it {
        expect(subject).to validate_numericality_of(:room_count)
          .only_integer
          .is_greater_than(0)
      }

      it 'nilの場合は有効であること' do
        office_overview = build(:office_overview)
        office_overview.room_count = nil
        expect(office_overview).to be_valid
      end
    end

    context 'opening_date' do
      let(:office_overview) { build(:office_overview) }

      it '現在の日付は有効であること' do
        office_overview.opening_date = Date.current
        expect(office_overview).to be_valid
      end

      it '過去の日付は有効であること' do
        office_overview.opening_date = Date.current - 1
        expect(office_overview).to be_valid
      end

      it '未来の日付は無効であること' do
        office_overview.opening_date = Date.current + 1
        expect(office_overview).not_to be_valid
      end

      it 'nilの場合は有効であること' do
        office_overview.opening_date = nil
        expect(office_overview).to be_valid
      end
    end
  end
end
