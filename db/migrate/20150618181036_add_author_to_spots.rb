class AddAuthorToSpots < ActiveRecord::Migration
  def change
    add_reference :spots, :author, index:true
  end
end
