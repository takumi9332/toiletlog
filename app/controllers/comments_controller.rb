class CommentsController < ApplicationController
  before_action :set_toilet
  before_action :authenticate_user!

  def create
    comment = Comment.create(comment_params)
    redirect_to "/toilets/#{comment.toilet.id}"
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to "/toilets/#{@comment.toilet.id}"
    end
  end

  private
  def set_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end

  def comment_params
    params.require(:comment).permit(:rate, :text).merge(user_id: current_user.id, toilet_id: params[:toilet_id])
  end
end
