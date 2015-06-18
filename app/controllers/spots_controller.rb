class SpotsController < ApplicationController
  before_filter :load_spot
  before_filter :load_user, except: [:new, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @spots = @user.spots.all
  end

  def create
    @spot.author = current_user
    if @spot.save
      redirect_to root_path, notice: "You have added #{Spot.name}!"
    else
      flash.alert = "We couldn't add your spot!. Please correct the errors below."
      render :new
    end
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
    @user = User.find(params[:user_id])
  end

  def spot_params
    params.require(:spot).permit(:author, :name, :img_url, :address, :phone, :category, :the_good, :the_bad, :the_ugly)
  end
end