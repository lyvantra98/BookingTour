class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :created_at]
    add_index :reviews, [:tour_id, :created_at]
  end
end
