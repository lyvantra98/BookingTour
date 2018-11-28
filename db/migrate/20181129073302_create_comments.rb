class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:review_id, :created_at]
  end
end
