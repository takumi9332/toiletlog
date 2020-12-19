class CreateToilets < ActiveRecord::Migration[6.0]
  def change
    create_table :toilets do |t|
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.integer :sex_id, null: false
      t.integer :type_id, null: false
      t.integer :washlet_id, null: false
      t.integer :clean_id, null:false
      t.text :info
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
