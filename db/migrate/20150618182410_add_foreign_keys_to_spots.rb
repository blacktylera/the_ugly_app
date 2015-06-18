class AddForeignKeysToSpots < ActiveRecord::Migration
  def change
    add_foreign_key(:spots, :users, column: :author_id)
  end
end