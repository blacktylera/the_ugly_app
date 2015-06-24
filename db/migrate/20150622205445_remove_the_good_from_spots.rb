class RemoveTheGoodFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :the_good
    remove_column :spots, :the_bad
    remove_column :spots, :the_ugly
  end
end
