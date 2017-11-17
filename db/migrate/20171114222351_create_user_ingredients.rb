class CreateUserIngredients < ActiveRecord::Migration[5.1]
  def change
  	create_table :useringredients do |t|
  		t.integer :user_id
  		t.integer :ingredient_id
  	end
  end
end
