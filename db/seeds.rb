# seeds_data/models直下の全ファイル読み込み
Dir[File.dirname(__FILE__) + '/seeds_data/models/*.rb'].each do |file|
  require file
end

Seed::Manager.create_managers

Seed::Office.create_offices

Seed::OfficeOverview.create_office_overviews
Seed::OfficeImage.create_thumbnails
Seed::OfficeImage.create_carousels
Seed::OfficeImage.create_features
Seed::Staffs.create_staffs
Seed::OfficeClient.create_office_clients