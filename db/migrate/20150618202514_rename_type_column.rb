class RenameTypeColumn < ActiveRecord::Migration
  def change
  	rename_column :spots, :type, :category
  end
end
