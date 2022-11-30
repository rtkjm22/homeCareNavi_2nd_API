# frozen_string_literal: true

require 'factory_bot_rails'

module Seed
  module Staffs

    def self.create_staffs
      office_ids = ::Office.ids
      puts "-----事業所1件につき10~50人程度のスタッフ作成-----"

      office_array = office_ids.map do |office_id|
        # スタッフの総数
        staff_all_count = rand(10..50)

        # 一般スタッフ数は総数の3/4
        worker_staff_count = staff_all_count * 3/4

        # ケアマネは総数の1/4
        care_manager_staff_count = staff_all_count * 1/4

        worker_list = FactoryBot.attributes_for_list(
          :staff,
          worker_staff_count,
          role: 0, # 0はworker
          office_id:
        )

        care_manager_list = FactoryBot.attributes_for_list(
          :staff,
          care_manager_staff_count,
          role: 1, # 1はcare_manager
          office_id:
        )

        [worker_list, care_manager_list]
      end

      ::Staff.insert_all!(office_array.flatten)

      puts "-----スタッフ作成完了-----"
    end

  end
end
