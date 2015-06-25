class SpotsController < ApplicationController
  before_filter :load_user, except: [:new, :create]
  before_action :require_login, except: [:index, :show]

  def new
    @spot = Spot.new
    @thegood = @spot.reviews.build(kind: "The Good")
    @thebad= @spot.reviews.build(kind: "The Bad")
    @theugly= @spot.reviews.build(kind: "The Ugly")
  end


  def create
    @spot = Spot.new
    @spot.assign_attributes(spot_params)
    @spot.author = current_user
    @spot.reviews.each do |review|
      review.author=current_user
    end
    # binding.pry
    if @spot.save
      redirect_to root_path, notice: "You have added #{Spot.name}!"
    else
      flash.alert = "We couldn't add your spot!. Please correct the errors below."
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @thegood = @spot.reviews.build(kind: "The Good")
    @thebad= @spot.reviews.build(kind: "The Bad")
    @theugly= @spot.reviews.build(kind: "The Ugly")
    @reviews = [@thegood, @thebad, @theugly]
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to root_path
  end

  private

  def load_spot
    if params[:id].present?
      @spot = Spot.find(params[:id])
    else
      @spot = Spot.new
    end

    if params[:spot].present?
      @spot.assign_attributes(spot_params)
    end
  end

  def load_user
    @user = current_user
  end

  def spot_params
    params.require(:spot).permit(:author, :name, :img_url, :address, :phone, :category, reviews_attributes: [:content, :kind])
  end
end
