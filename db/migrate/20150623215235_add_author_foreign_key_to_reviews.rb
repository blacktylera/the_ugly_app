class AddAuthorForeignKeyToReviews < ActiveRecord::Migration
  def change
    add_foreign_key(:reviews, :spots, column: :author_id)
  end
end