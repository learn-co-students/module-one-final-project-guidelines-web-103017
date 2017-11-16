class AddUrlToWaterbody < ActiveRecord::Migration[5.1]
  def change
    add_column :waterbodies, :url, :string
  end
end
