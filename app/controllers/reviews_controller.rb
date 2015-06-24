class ReviewsController < ApplicationController
  # def index
  #   @reviews = Review.all
  # end

  # def new
  #   @review = Review.new
  #   puts params.to_s
  #   @spot = Spot.find(params[:spot_id])
  #   @thegood = @spot.reviews.build(kind: "The Good")
  #   @thebad= @spot.reviews.build(kind: "The Bad")
  #   @theugly= @spot.reviews.build(kind: "The Ugly")
  # end


  def create
    @spot = Spot.find(params[:spot_id])
    params[:reviews].each do |review_params|
      review_params = review_params.permit(:content, :kind)
      review = @spot.reviews.build(review_params)
      review.author=current_user
      review.save
    end
    if @spot.save
      redirect_to root_path, notice: "You have added your review!"
    else
      flash.alert = "We couldn't add your review!. Please correct the errors below."
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:content, :kind)
  end


end
