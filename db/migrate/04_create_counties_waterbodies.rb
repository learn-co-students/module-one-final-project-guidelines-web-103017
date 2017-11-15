class CreateCountiesWaterbodies < ActiveRecord::Migration
  def change
    create_table :counties_waterbodies do |t|
      t.integer :county_id
      t.integer :waterbody_id
    end
  end
end
