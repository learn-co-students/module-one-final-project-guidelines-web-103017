class CreateBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :style
      t.integer :abv
      t.string :description
      t.string :isorganic
      t.integer :rating
      t.string :api_key
      t.integer :brewery_id
    end
  end
end
