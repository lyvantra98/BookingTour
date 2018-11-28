class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :status, default: 0
      t.integer :number_people
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true

      t.timestamps
    end
    add_index :bookings, [:user_id, :created_at]
    add_index :bookings, [:tour_id, :created_at]
  end
end
