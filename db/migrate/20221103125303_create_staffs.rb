class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.references :office, null: false, foreign_key: true, index: { unique: true }
      t.string :name, null: false, comment: 'スタッフの名前'
      t.string :kana, null: false, comment: 'スタッフの名前の読み仮名'
      t.string :introduction, comment: 'スタッフの紹介文'
      t.boolean :section, default: false

      t.timestamps
    end
  end
end
