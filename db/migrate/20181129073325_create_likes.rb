class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.timestamps
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
    end
    add_index :likes, [:user_id, :created_at]
    add_index :likes, [:review_id, :created_at]
  end
end
