class CreateVoteHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :vote_type, null: false

      t.timestamps
    end
  end
end
