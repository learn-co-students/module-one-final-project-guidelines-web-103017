class CreateWaterbodyAmenities < ActiveRecord::Migration[5.1]
  def change
    create_table :waterbody_amenities do |t|
      t.integer :waterbody_id
      t.integer :amenity_id
    end
  end
end
