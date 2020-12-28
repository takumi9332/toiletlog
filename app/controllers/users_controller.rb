class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @toilets = user.toilets.page(params[:page]).per(10)
  end
end
