class CreateOfficeOverviews < ActiveRecord::Migration[7.0]
  def change
    create_table :office_overviews do |t|
      t.references :office, null: false, foreign_key: true, index: { unique: true }
      t.string :classify, comment: '類型'
      t.date :opening_date, comment: '開設年月'
      t.integer :room_count, comment: '居室数'
      t.string :requirements, comment: '入居時の要件'
      t.string :shared_facilities, comment: '共用設備'
      t.string :business_entity, comment: '経営・事業主体'
      t.string :official_site_url, comment: '公式サイトのurl'

      t.timestamps
    end
  end
end
