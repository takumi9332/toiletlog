class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.float :rate, null: false, default: 0
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true
      t.references :toilet, null: false, foreign_key: true
      t.timestamps
    end
  end
end
