class ToiletsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_toilet, only: [:show, :edit, :update, :destroy]
  before_action :create_searching_object, only: [:index, :search_toilet]

  def index
    @toilets = Toilet.includes(:user).page(params[:page]).per(6)
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

  def show
    @comment = Comment.new
    @comments = @toilet.comments.includes(:user).order("created_at DESC")
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
      render :edit
    end
  end

  def destroy
    unless current_user.id == @toilet.user_id
      redirect_to action: :index
    end
    @toilet.destroy
    redirect_to root_path
  end

  def search_toilet
    @results = @p.result.page(params[:page]).per(6)
  end

  private
  def toilet_params
    params.require(:toilet).permit(:image, :prefecture_id, :city, :address, :building, :sex_id, :type_id, :washlet_id, :clean_id, :info).merge(user_id: current_user.id)
  end

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def create_searching_object
    @p = Toilet.ransack(params[:q])
  end
end
