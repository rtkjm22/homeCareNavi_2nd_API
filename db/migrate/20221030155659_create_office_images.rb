class CreateOfficeImages < ActiveRecord::Migration[7.0]
  def change
    create_table :office_images do |t|
      t.references :office, null: false, foreign_key: true
      t.string :caption
      t.integer :role, null: false

      t.timestamps
    end
  end
end
