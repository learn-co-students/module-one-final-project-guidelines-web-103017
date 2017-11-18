class CreateBeeringredients < ActiveRecord::Migration[5.0]
  def change
    create_table :beeringredients do |t|
      t.integer :beer_id
      t.integer :ingredient_id
    end
  end
end
