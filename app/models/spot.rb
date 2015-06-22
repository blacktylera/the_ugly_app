class Spot < ActiveRecord::Base
	belongs_to :author, class_name: "User"

	validates :author, :name, :img_url, :address, :phone, :category, :the_good, :the_bad, :the_ugly, presence: true

	filterrific(
	  default_filter_params: { sorted_by: 'created_at_desc' },
	  available_filters: [
		:sorted_by,
		:search_query
	  ]
	)

	scope :search_query, lambda { |query|
	  return nil  if query.blank?
	  terms = query.downcase.split(/\s+.*/)
	  terms = terms.map { |e|
		(e.gsub('*', '%') + '%').gsub(/%+/, '%')
	  }
	  num_or_conditions = 4
	  where(
		terms.map {
		  or_clauses = [
			"LOWER(spots.name) LIKE ?",
			"LOWER(spots.category) LIKE ?",
			"LOWER(spots.address) LIKE ?",
			"LOWER(spots.phone) LIKE ?"
		  ].join(' OR ')
		  "(#{ or_clauses })"
		}.join(' AND '),
		*terms.map { |e| [e] * num_or_conditions }.flatten
	  )
	}

	# scope :with_category, lambda { |categories|
	# 	where(category: [*categories])
	# }

	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
	    order("spots.created_at #{ direction }")
	  when /^name_/
	    # Simple sort on the name colums
	    order("LOWER(spots.name) #{ direction }")
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
	}


	/def self.options_for_with_category
	    [
	      ['Name (a-z)', 'name_asc'],
	      ['Registration date (newest first)', 'created_at_desc'],
	      ['Registration date (oldest first)', 'created_at_asc'],
	      ['Spot (a-z)', 'spot_name_asc']
	    ]
	end/

end
