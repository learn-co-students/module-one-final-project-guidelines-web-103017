class CreateWaterbodies < ActiveRecord::Migration[4.2]
  def change
    create_table :waterbodies do |t|
      t.string :name
    end
  end
end
