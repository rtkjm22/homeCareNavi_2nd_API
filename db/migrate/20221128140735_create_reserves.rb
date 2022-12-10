class CreateReserves < ActiveRecord::Migration[7.0]
  def change
    create_table :reserves do |t|
      t.references :office, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.datetime :interview_begin_at, null: false, comment: '面談開始時間'
      t.datetime :interview_end_at, null: false, comment: '面談終了時間'
      t.string :user_name, null: false, comment: '予約者の名前'
      t.integer :user_age, null: false, comment: '予約者の年齢'
      t.string :contact_tel, null: false, comment: '予約者の電話番号'
      t.text :note, comment: '予約者の困り事'
      t.boolean :is_contacted, default: false, comment: '事業者側が予約者に連絡を取っていたらTRUE'

      t.timestamps
    end
  end
end
