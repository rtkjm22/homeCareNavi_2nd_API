# frozen_string_literal: true

require 'factory_bot_rails'

module Seed
  module OfficeOverview

    def self.create_office_overviews
      office_ids = ::Office.ids
      puts "-----#{office_ids.count}件の事業所詳細作成-----"

      office_overview_array = office_ids.map do |office_id|
        FactoryBot.attributes_for(:office_overview, office_id:)
      end
      ::OfficeOverview.insert_all!(office_overview_array)

      puts '-----事業所詳細作成完了-----'
    end
  end
end
