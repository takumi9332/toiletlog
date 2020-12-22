class ToiletsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_toilet, only: [:show, :edit, :update, :destroy]

  def index
    @toilets = Toilet.includes(:user)
  end

  def new
    @toilet = Toilet.new
  end

  def create
    @toilet = Toilet.new(toilet_params)
    if @toilet.save
      redirect_to root_path
    else
      redirect_to action: :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @toilet.comments.includes(:user)
  end

  def edit
    unless current_user.id == @toilet.user_id
      redirect_to action: :index
    end
  end

  def update
    if @toilet.update(toilet_params)
      redirect_to action: :show
    else
      redirect_to action: :edit
    end
  end

  def destroy
    unless current_user.id == @toilet.user_id
      redirect_to action: :index
    end
    @toilet.destroy
    redirect_to root_path
  end

  def search
    @toilets = Toilet.search(params[:keyword])
  end

  private
  def toilet_params
    params.require(:toilet).permit(:image, :prefecture_id, :city, :address, :building, :sex_id, :type_id, :washlet_id, :clean_id, :info).merge(user_id: current_user.id)
  end

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end
end
