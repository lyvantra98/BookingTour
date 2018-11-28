class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.boolean :is_admin, null: false, default: false

      t.timestamps
    end
  end
end
