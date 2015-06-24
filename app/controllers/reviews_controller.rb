class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    @thegood = @review.reviews.build(kind: "The Good")
    @thebad= @review.reviews.build(kind: "The Bad")
    @theugly= @review.reviews.build(kind: "The Ugly")
  end


  def create
    @review = Review.new
    @review.assign_attributes(review_params)
    @review.author = current_user
    @review.reviews.each do |review|
      review.author=current_user
    end
    if @review.save
      redirect_to root_path, notice: "You have added your review!"
    else
      flash.alert = "We couldn't add your review!. Please correct the errors below."
      render :new
    end
  end


end
