class CreateUserRecipe < ActiveRecord::Migration[5.1]
  def change
  	create_table :userrecipes do |t|
  		t.integer :user_id
  		t.integer :recipe_id
  	end
  end
end
