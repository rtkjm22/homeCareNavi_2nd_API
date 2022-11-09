require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'StaffModel' do
    context '関連付け' do 
      it { is_expected.to belong_to(:office) }
    end

    context 'office_id、name、furiganaがある場合、有効である' do
      it 'スタッフの登録ができる' do
        staff = create(:staff)
        expect(staff).to be_valid
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
