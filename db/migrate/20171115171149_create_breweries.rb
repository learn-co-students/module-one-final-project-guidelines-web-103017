class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries do |t|
      t.string :name
      t.text :description
      t.string :classification
      t.integer :established
      t.string :website
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :postalcode
      t.string :api_key
    end
  end
end
