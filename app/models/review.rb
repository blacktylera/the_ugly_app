class Review < ActiveRecord::Base
	acts_as_votable
	belongs_to :author, class_name: "User"
	belongs_to :spot, class_name: "Spot"

	validates :author, presence: true

	self.per_page = 1

	default_scope -> {order(:cached_weighted_average => :desc)}
end
