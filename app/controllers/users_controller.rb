class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @toilets = user.toilets.order("created_at DESC").page(params[:post_page]).per(4)

    @favorites = current_user.favorite_toilets.order("created_at DESC").page(params[:favorite_page]).per(4)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
