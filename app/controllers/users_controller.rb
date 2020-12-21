class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @toilets = user.toilets
  end
end
