class Spot < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :author, :name, :img_url, :address, :phone, :type, :the_good, :the_bad, :the_ugly, presence: true
end
