require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'StaffModel' do
    context '関連付け' do 
      it { is_expected.to belong_to(:office) }
     
      it do
        staff_create = create(:staff)
        staff_build = build(:staff)
      end

      it '親を削除しないと、削除できないこと' do
        staff_create.destroy
        expect(destroy.errors.full_messages[0]).to eq 'このモデルのみを削除することはできません。削除する場合は、親を削除してください。'
      end
    end

    context 'office_id、name、furiganaがある場合、有効である' do
      it 'スタッフの登録ができる' do
        expect(staff_build).to be_valid
      end 
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end
    context 'furigana' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
