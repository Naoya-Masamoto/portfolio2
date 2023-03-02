class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.text :body, null:false
      t.string :img
      t.string :video
      t.references :user, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :shape, null: false, foreign_key: true

      t.timestamps
    end
  end
end
