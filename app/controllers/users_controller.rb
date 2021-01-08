class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @toilets = user.toilets.order("created_at DESC").page(params[:page]).per(4)

    favorites = Favorite.where(user_id: current_user.id).pluck(:toilet_id)
    @favorite_list = Toilet.order("created_at DESC").page(params[:page]).per(4).find(favorites)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
