class CreateOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :offices do |t|
      # Managerと1対1であることを保証するため、ユニーク付与
      t.references :manager, null: false, foreign_key: { to_table: :users }, index: { unique: true }
      t.string :name, null: false, default: '未編集'
      t.string :feature_title, null: false, default: '未編集'
      t.text :feature_detail, null: false, default: '未編集'
      t.integer :workday, null: false, default: 0, limit: 8
      t.string :workday_detail, null: false, default: '未編集'
      t.decimal :lat, precision: 8, scale: 6
      t.decimal :lng, precision: 9, scale: 6
      t.string :fax, null: false, default: '未編集'
      t.string :nearest_station, null: false, default: '未編集'

      t.timestamps
    end

    # 検索時に高速化させるためのインデックス
    add_index :offices, :name
    add_index :offices, :feature_title
    add_index :offices, :feature_detail
    add_index :offices, :lat
    add_index :offices, :lng
    add_index :offices, :nearest_station
  end
end
