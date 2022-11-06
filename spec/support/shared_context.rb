# コードの重複を減らすため、Manager,Office,OfficeOverview,OfficeImageを一度に定義する
# @example
#   describe '何らかのテスト' do
#     include_context 'setup_office'
#     it '何らかのテスト' do
#       login manger
#       office.~~~
#   end
RSpec.shared_context 'setup_office' do
  let!(:manager) { create(:manager) }
  let!(:office) { create(:office, manager:) }
  let!(:office_overview) { create(:office_overview, office:) }
  let!(:office_image) { create(:office_image, office:) }
end
