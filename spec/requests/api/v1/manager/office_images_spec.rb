require 'rails_helper'

RSpec.describe 'Api::V1::Manager::OfficeImages' do
  describe 'POST /api/v1/manager/office_images' do
    let!(:office) { create(:office) }
    let!(:new_office_image) do
      attrs = attributes_for(:office_image, office:)
      attrs[:image] = Rack::Test::UploadedFile.new('spec/fixtures/test_image.jpg', 'image/jpg')
      attrs
    end

    context 'ケアマネでログインした場合' do
      it '有効な属性値の場合、事業所画像を作成できること' do
        login office.manager
        expect do
          post api_v1_manager_office_images_path,
               params: new_office_image,
               headers: { ContentType: 'multipart/form-data' }
        end.to change(OfficeImage, :count).by(1)
        assert_response_schema_confirm(200)
      end

      it '無効な属性値の場合、エラーが返ってくること' do
        login office.manager
        new_office_image[:role] = nil
        expect do
          post api_v1_manager_office_images_path,
               params: new_office_image,
               headers: { ContentType: 'multipart/form-data' }
        end.not_to change(OfficeImage, :count)
        assert_response_schema_confirm(400)
      end
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      post api_v1_manager_office_images_path,
           params: new_office_image,
           headers: { ContentType: 'multipart/form-data' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      client = create(:client)
      login client
      post api_v1_manager_office_images_path,
           params: new_office_image,
           headers: { ContentType: 'multipart/form-data' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /api/v1/manager/office_images/:id' do
    let!(:office_image) { create(:office_image) }
    let!(:update_office_image) do
      attrs = attributes_for(:office_image)
      attrs[:role] = 'feature'
      attrs[:image] = Rack::Test::UploadedFile.new('spec/fixtures/test_image2.jpg', 'image/jpg')
      attrs
    end

    context 'ケアマネでログインした場合' do
      it '有効な属性値の場合、事業所画像を更新できること' do
        login office_image.office.manager
        patch api_v1_manager_office_image_path(office_image),
              params: update_office_image,
              headers: { ContentType: 'multipart/form-data' }
        office_image.reload
        expect(office_image.role).to eq 'feature'
        expect(office_image.image.filename.to_s).to eq 'test_image2.jpg'
        assert_response_schema_confirm(200)
      end

      it '他のケアマネの画像idをパスパラメータに渡した場合、エラーが返ってくること' do
        office_image_another = create(:office_image)
        login office_image.office.manager
        expect do
          patch api_v1_manager_office_image_path(office_image_another),
                params: update_office_image,
                headers: { ContentType: 'multipart/formdata' }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it '無効な属性値の場合、エラーが返ってくること' do
        login office_image.office.manager
        update_office_image[:role] = nil
        patch api_v1_manager_office_image_path(office_image),
              params: update_office_image,
              headers: { ContentType: 'multipart/form-data' }
        assert_response_schema_confirm(400)
      end
    end

    it 'ログインしていない場合、エラーが返ってくること' do
      patch api_v1_manager_office_image_path(office_image),
            params: update_office_image,
            headers: { ContentType: 'multipart/form-data' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'クライアントでログインした場合、エラーが返ってくること' do
      client = create(:client)
      login client
      patch api_v1_manager_office_image_path(office_image),
            params: update_office_image,
            headers: { ContentType: 'multipart/form-data' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
