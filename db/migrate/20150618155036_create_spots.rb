class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name
      t.string :img_url
      t.text :address
      t.string :phone
      t.string :type
      t.string :the_good
      t.string :the_bad
      t.string :the_ugly

      t.timestamps null: false
    end
  end
end
