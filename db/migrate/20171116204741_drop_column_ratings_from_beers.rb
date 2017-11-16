class DropColumnRatingsFromBeers < ActiveRecord::Migration[5.0]
  def change
    remove_column :beers, :rating
  end
end
