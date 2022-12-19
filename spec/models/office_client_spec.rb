require 'rails_helper'

RSpec.describe OfficeClient do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:staff) }
      it { is_expected.to have_one_attached(:avatar) }
    end

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(200) }
    end

    context 'age' do
      it { is_expected.to validate_presence_of(:age) }

      it {
        expect(subject).to validate_numericality_of(:age)
          .only_integer
          .is_greater_than(0)
      }
    end

    context 'furigana' do
      it { is_expected.to validate_presence_of(:furigana) }
      it { is_expected.to validate_length_of(:furigana).is_at_most(200) }
    end

    context 'postal' do
      it { is_expected.to validate_presence_of(:postal) }
      it { is_expected.to validate_length_of(:postal).is_at_most(8) }
    end

    context 'address' do
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_length_of(:address).is_at_most(200) }
    end

    context 'family' do
      it { is_expected.to validate_presence_of(:family) }
    end

    context 'avatar' do
      it do
        expect(subject).to validate_content_type_of(:avatar)
          .allowing('image/jpg', 'image/jpeg', 'image/png')
      end

      it { is_expected.to validate_size_of(:avatar).less_than(5.megabytes) }
    end
  end

  describe 'avatar_urlメソッド' do
    it '画像が存在する場合、画像のURLが返ってくること' do
      office_client = create(:office_client, :with_avatar)
      expect(office_client.avatar_url).to be_start_with('http://localhost:3000/rails/active_storage/blobs/redirect')
      expect(office_client.avatar_url).to be_end_with('test_image.jpg')
    end

    it '画像が存在しない場合、nilが返ってくること' do
      office_client = create(:office_client)
      expect(office_client.avatar_url).to be_nil
    end
  end
end
