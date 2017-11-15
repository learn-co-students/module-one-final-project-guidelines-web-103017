class CreateCountiesWaterbodies < ActiveRecord::Migration[4.2]
  def change
    create_table :counties_waterbodies do |t|
      t.integer :county_id
      t.integer :waterbody_id
    end
  end
end
