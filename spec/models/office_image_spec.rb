require 'rails_helper'

RSpec.describe OfficeImage, type: :model do
  describe 'バリデーション' do
    context '関連付け' do
      it { is_expected.to belong_to(:office) }
      it { is_expected.to have_one_attached :image }
    end

    # 画像のテストは重いため、基本は除外し、節目で実行する
    xcontext 'image' do
      it do
        expect(subject).to validate_content_type_of(:image)
          .allowing('image/jpg', 'image/jpeg', 'image/png')
      end

      it { is_expected.to validate_size_of(:image).less_than(5.megabytes) }
    end

    context 'caption' do
      it { is_expected.to validate_length_of(:caption).is_at_most(200) }
    end

    context 'role' do
      it do
        expect(subject).to define_enum_for(:role)
          .with_values(%i[thumbnail carousel feature])
      end

      it { is_expected.to validate_presence_of(:role) }
    end
  end

  describe 'image_urlメソッド' do
    let!(:office_image) { create(:office_image) }

    it '画像が存在する場合、画像のURLが返ってくること' do
      expect(office_image.image_url).to be_start_with('http://localhost:3000/rails/active_storage/blobs/redirect')
      expect(office_image.image_url).to be_end_with('test_image.jpg')
    end

    it '画像が存在しない場合、nilが返ってくること' do
      office_image.image.purge
      expect(office_image.image_url).to be_nil
    end
  end
end
