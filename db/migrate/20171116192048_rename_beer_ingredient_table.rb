class RenameBeerIngredientTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :beeringredients, :beer_ingredients
  end
end
