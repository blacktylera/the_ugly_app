class Review < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :spot, class_name: "Spot"

	validates :author, presence: true
end
