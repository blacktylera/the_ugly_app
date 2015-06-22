class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :kind
      t.text :review

      t.timestamps null: false
    end
  end
end
