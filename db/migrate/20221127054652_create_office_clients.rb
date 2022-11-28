class CreateOfficeClients < ActiveRecord::Migration[7.0]
  def change
    create_table :office_clients do |t|
      t.references :staff, null: false, foreign_key: true
      t.string :name, null: false, comment: '事業所利用者名'
      t.integer :age, null: false, comment: '年齢'
      t.string :furigana, null: false, comment: '名前のふりがな'
      t.string :postal, null: false, comment: '郵便番号'
      t.string :address, null: false, comment: '住所'
      t.string :family, null: false, comment: '家族情報'

      t.timestamps
    end
  end
end
