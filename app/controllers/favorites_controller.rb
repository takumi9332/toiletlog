class FavoritesController < ApplicationController
  before_action :set_toilet
  before_action :authenticate_user!

  def create
    if @toilet.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, toilet_id: @toilet.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, toilet_id: @toilet.id)
    @favorite.destroy
  end

  private
  def set_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end
end
