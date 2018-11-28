class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.integer :status, null: false, default: 1
      t.string :name
      t.date :date_from
      t.date :date_to
      t.string :location_from
      t.string :location_to
      t.float :price
      t.integer :max_people
      t.integer :min_people
      t.text :description
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :tours, [:category_id, :created_at]
  end
end
