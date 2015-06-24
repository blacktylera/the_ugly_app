class AddForeignKeysToReviews < ActiveRecord::Migration
  def change
    add_foreign_key(:reviews, :users, column: :author_id)
    add_foreign_key(:reviews, :spots, column: :spot_id)
  end
end
