class SpotsController < ApplicationController
  before_filter :load_spot
  before_action :require_login

  def create
    @spot.author = current_user
    if @spot.save
      redirect_to user_spots_path(current_user), notice: "You have added #{Spot.name}!"
    else
      flash.alert = "We couldn't add your spot!. Please correct the errors below."
      render :new
    end
  end

  private

  def load_spot
    @spot = Spot.new
    if params[:spot].present?
      @spot.assign_attributes(spot_params)
    end
  end

  def spot_params
    params.require(:spot).permit(:author, :name, :img_url, :address, :phone, :type, :the_good, :the_bad, :the_ugly)
  end
end