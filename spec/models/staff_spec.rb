require 'rails_helper'

RSpec.describe Staff do
  describe 'StaffModel' do
    context '関連付け' do
      it { is_expected.to belong_to(:office) }
      it { is_expected.to have_many(:office_clients).dependent(:restrict_with_error) }
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'furigana' do
      it { is_expected.to validate_presence_of(:furigana) }
    end
  end
end
