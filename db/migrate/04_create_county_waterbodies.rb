class CreateCountyWaterbodies < ActiveRecord::Migration[4.2]
  def change
    create_table :county_waterbodies do |t|
      t.integer :county_id
      t.integer :waterbody_id
    end
  end
end
