# Manager,Office,OfficeOverview,OfficeImageを一度に定義する
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
  let!(:office_image_thumbnail) { create(:office_image, office:, role: :thumbnail) }
  let!(:office_image_carousels) { create_list(:office_image, 5, office:, role: :carousel) }
  let!(:office_image_features) { create_list(:office_image, 2, office:, role: :feature) }
  let!(:staff_worker) { create(:staff, office:, role: :worker) }
  let!(:staff_care_manager) { create(:staff, office:, role: :care_manager) }
end
