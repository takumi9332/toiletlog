class ToiletsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  def index
    @toilets = Toilet.all
    # @toilets = Toilet.includes(:user).order("rate DESC")
  end

  def new
    @toilet = Toilet.new
  end

  def create
    @toilet = Toilet.new(toilet_params)
    if @toilet.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def toilet_params
    params.require(:toilet).permit(:image, :prefecture_id, :city, :address, :building, :sex_id, :type_id, :washlet_id, :clean_id, :info).merge(user_id: current_user.id)
  end
end
