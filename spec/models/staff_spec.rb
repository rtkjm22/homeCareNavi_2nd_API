require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'StaffModel' do
    context '関連付け' do 
      it { is_expected.to belong_to(:office) }
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end
    context 'furigana' do
      it { is_expected.to validate_presence_of(:furigana) }
    end
  end
end
