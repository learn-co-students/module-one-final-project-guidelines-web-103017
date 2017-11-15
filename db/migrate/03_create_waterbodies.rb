class CreateWaterbodies < ActiveRecord::Migration
  def change
    create_table :waterbodies do |t|
      t.string :name
    end
  end
end
