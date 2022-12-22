# frozen_string_literal: true

require 'factory_bot_rails'

module Seed
  module Client
    def self.create_clients
      puts '-----50人のクライアント作成-----'

      FactoryBot.create_list(:client, 50, password: 'password')

      puts "\n-----クライアント作成完了-----"
    end
  end
end
