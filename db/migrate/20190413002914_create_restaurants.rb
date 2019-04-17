class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :user_id
      t.integer :cuisine_id
      t.integer :neighborhood_id
    end
  end
end
