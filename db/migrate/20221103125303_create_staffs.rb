class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.references :office, null: false, foreign_key: true, index: { unique: true }
      t.string :name, null: false, comment: 'スタッフの名前'
      t.string :furigana, null: false, comment: 'スタッフの名前の読み仮名'
      t.text :introduction, comment: 'スタッフの紹介文'
      t.integer :role, default: false, comment: 'スタッフの役職をenumで管理する'

      t.timestamps
    end
  end
end
