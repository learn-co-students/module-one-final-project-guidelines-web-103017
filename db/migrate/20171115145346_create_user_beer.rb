class CreateUserBeer < ActiveRecord::Migration[5.0]
  def change
    create_table :userbeers do |t|
      t.integer :beer_id
      t.integer :user_id
      t.integer :rating
    end
  end
end
