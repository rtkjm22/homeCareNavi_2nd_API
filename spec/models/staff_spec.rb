require 'rails_helper'

RSpec.describe Staff do
  describe 'StaffModel' do
    context '関連付け' do
      it { is_expected.to belong_to(:office) }
      it { is_expected.to have_many(:office_clients).dependent(:restrict_with_error) }
      it { is_expected.to have_one_attached :avatar }
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'furigana' do
      it { is_expected.to validate_presence_of(:furigana) }
    end

    context 'avatar' do
      it do
        expect(subject).to validate_content_type_of(:avatar)
          .allowing('image/jpg', 'image/jpeg', 'image/png')
      end

      it { is_expected.to validate_size_of(:avatar).less_than(5.megabytes) }
    end
  end
end
