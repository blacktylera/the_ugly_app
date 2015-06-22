class AddUsersSpotsToReviews < ActiveRecord::Migration
	def change
	    add_reference :reviews, :author, index:true
	    add_reference :reviews, :spot, index:true
	end
end


