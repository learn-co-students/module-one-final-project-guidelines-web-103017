class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :name
    end
  end
end
