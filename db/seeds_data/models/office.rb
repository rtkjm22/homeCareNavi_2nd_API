# frozen_string_literal: true
require 'factory_bot_rails'
require 'csv'

module Seed
  module Office
    def self.create_offices
      managers = ::Manager.all
      puts "-----#{managers.size}件の事業所作成-----"

      # lat,lngを入力するためcsv読み込み
      user_csv_table = CSV.read(Rails.root.join('db/seeds_data/csvs/users_300.csv'), headers: true)

      office_array = managers.map do |manager|
        # managerと一致するアドレスのcsv行取得
        row = user_csv_table.find { |user| user['address'] == manager.address }
        row.to_h.symbolize_keys => { lat:, lng: }
        FactoryBot.attributes_for(:office, lat:, lng:, manager_id: manager.id, workday: 62) # 62は平日全部
      end

      ::Office.insert_all!(office_array)

      puts '-----事業所作成完了-----'
    end
  end
end
