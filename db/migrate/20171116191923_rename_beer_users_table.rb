class RenameBeerUsersTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :userbeers, :user_beers
  end
end
