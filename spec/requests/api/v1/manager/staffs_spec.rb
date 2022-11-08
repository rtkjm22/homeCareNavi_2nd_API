require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'StaffAPI' do
    context '/api/v1/staffs' do 
      it '全てのスタッフを取得する' do
        FactoryBot.create_list(:staff, 10)
  
        get '/api/v1/staffs'
        json = JSON.parse(response.body)
  
        expect(response.status).to eq(200)
  
        expext(json['data'].length).to eq(10)
      end
    end
  end
end
