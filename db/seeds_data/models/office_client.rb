# frozen_string_literal: true

require 'factory_bot_rails'

module Seed
  module OfficeClient

    def self.create_office_clients
      puts '-----事業所管理のクライアント作成-----'

      staff_ids = ::Staff.ids
      office_client_array = staff_ids.map do |staff_id|
        FactoryBot.attributes_for(:office_client, staff_id:)
      end
      ::OfficeClient.insert_all!(office_client_array)

      puts '-----事業所管理クライアント作成完了-----'
    end
  end
end
