# frozen_string_literal: true

require 'csv'

module Seed
  module Manager
    def self.create_managers
      puts '-----300人のケアマネ作成-----'

      CSV.foreach('db/seeds_data/csvs/users_300.csv', headers: true, encoding: 'BOM|UTF-8') do |row|
        attrs = row.to_h
        # 元のcsvからlat,lngを削除
        attrs = attrs.except('lat','lng')
        # パスは全て"password"とし, confirmed_atに時間を入れることで認証済みとする
        attrs = attrs.merge(password: 'password', confirmed_at: Date.current.in_time_zone)
        manager = ::Manager.create!(attrs)
        print manager.id
      end

      puts "\n-----ケアマネ作成完了-----"
    end
  end
end
