class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
  	create_table :recipeingredients do |t|
  		t.integer :recipe_id
  		t.integer :ingredient_id
  	end
  end
end
