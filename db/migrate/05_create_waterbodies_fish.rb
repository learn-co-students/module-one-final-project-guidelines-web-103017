class CreateWaterbodiesFish < ActiveRecord::Migration
  def change
    create_table :waterbodies_fish do |t|
      t.integer :waterbody_id
      t.integer :fish_id
    end
  end
end
