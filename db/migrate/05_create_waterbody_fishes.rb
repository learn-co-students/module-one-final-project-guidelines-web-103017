class CreateWaterbodyFishes < ActiveRecord::Migration[4.2]
  def change
    create_table :waterbody_fishes do |t|
      t.integer :waterbody_id
      t.integer :fish_id
    end
  end
end
