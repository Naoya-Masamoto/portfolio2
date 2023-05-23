class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :cool
      t.integer :cute
      t.integer :tasteful
      t.integer :beautiful
      t.integer :good_sense
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
