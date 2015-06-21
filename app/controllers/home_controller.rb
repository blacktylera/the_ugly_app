class HomeController < ApplicationController
	def index
		@filterrific = initialize_filterrific(
		  Spot,
		  params[:filterrific]
		) or return
		@spots = @filterrific.find.page(params[:page])

		respond_to do |format|
		  format.html
		  format.js
		end
	end
end