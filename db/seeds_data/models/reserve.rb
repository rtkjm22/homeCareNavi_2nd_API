# frozen_string_literal: true

require 'factory_bot_rails'

module Seed
  module Reserve
    def self.create_reserves
      puts '-----全事業所に0~5件の予約作成-----'

      offices = ::Office.all
      client_ids = ::Client.ids

      reserve_list = offices.map do |office|
        rand(0..5).times.map do
          client_id = client_ids.sample
          FactoryBot.attributes_for(:reserve, office_id: office.id, client_id:)
        end
      end

      ::Reserve.insert_all!(reserve_list.flatten)

      puts "\n-----予約作成完了-----"
    end
  end
end
